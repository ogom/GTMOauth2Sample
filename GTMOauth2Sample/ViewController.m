//
//  ViewController.m
//  GTMOauth2Sample
//
//  Created by ogom on 12/09/16.
//  Copyright (c) 2012 ogom. All rights reserved.
//

#import "ViewController.h"
#import "GTMOAuth2ViewControllerTouch.h"
#import "GTMOAuth2SignIn.h"
#import "JSON.h"

@interface NSURLRequest(PrivateAPI)
+ (void)setAllowsAnyHTTPSCertificate:(BOOL)allow forHost:(NSString*)host;
@end

@interface ViewController ()
@property (retain, nonatomic) GTMOAuth2Authentication *auth;
@end

@implementation ViewController

@synthesize accessTokenTextView = _accessTokenTextView;
@synthesize responseTextView = _responseTextView;

/* appiaries */
static NSString *const kOAuthProvider       = @"Custom";
static NSString *const kKeychainItemName    = @"OAuth Custom";
static NSString *const kOAuthScope          = @"profile";
static NSString *const kAuthorizationURL    = @"https://api-oauth.appiaries.com/v1/auth";
static NSString *const kTokenURL            = @"https://api-oauth.appiaries.com/v1/token";
static NSString *const kRedirectURI         = @"http://callback/oauth";
static NSString *const kUsersMeURI          = @"https://api-profiles.appiaries.com/v1/_sandbox/gtmoauth2sample";
static NSString *const kClientID            = @"89a5b2b16ed00fd";
static NSString *const kClientSecret        = @"21a3f8c852963566cd4e62a869a82";

/* Authorization Request */
- (void)signInToCustom {
    GTMOAuth2Authentication *auth = [self authForCustom];
    auth.scope = kOAuthScope;
    auth.shouldAuthorizeAllRequests = YES;
    NSURL *authURL = [NSURL URLWithString:kAuthorizationURL];
    //[NSURLRequest setAllowsAnyHTTPSCertificate: YES forHost:[authURL host]];
    
    GTMOAuth2ViewControllerTouch *viewController;
    viewController = [[[GTMOAuth2ViewControllerTouch alloc] initWithAuthentication:auth
                                                                  authorizationURL:authURL
                                                                  keychainItemName:kKeychainItemName
                                                                          delegate:self
                                                                  finishedSelector:@selector(viewController:finishedWithAuth:error:)] autorelease];
    
    [[self navigationController] pushViewController:viewController animated:YES];
}

/* Access Token Request */
- (GTMOAuth2Authentication *)authForCustom {
    NSURL *tokenURL = [NSURL URLWithString:kTokenURL];
    //[NSURLRequest setAllowsAnyHTTPSCertificate: YES forHost:[tokenURL host]];
    
    GTMOAuth2Authentication *auth;
    auth = [GTMOAuth2Authentication authenticationWithServiceProvider:kOAuthProvider
                                                             tokenURL:tokenURL
                                                          redirectURI:kRedirectURI
                                                             clientID:kClientID
                                                         clientSecret:kClientSecret];
    return auth;
}

- (void)viewController:(GTMOAuth2ViewControllerTouch *)viewController finishedWithAuth:(GTMOAuth2Authentication *)auth error:(NSError *)error {
    if (error != nil) {
        NSLog(@"Authentication error: %@", error);
    } else {
        NSLog(@"Authentication : %@", auth);
        self.auth = auth;
        self.accessTokenTextView.text = self.auth.accessToken;
        [self getMeFetch];
    }
}

- (void)getMeFetch {
    NSURL *url = [NSURL URLWithString:kUsersMeURI];
    //[NSURLRequest setAllowsAnyHTTPSCertificate: YES forHost:[url host]];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    GTMHTTPFetcher *fetcher = [GTMHTTPFetcher fetcherWithRequest:request];
    [fetcher setAuthorizer:self.auth];
    [fetcher beginFetchWithDelegate:self didFinishSelector:@selector(fetcher:finishedWithData:error:)];
}

- (void)fetcher:(GTMHTTPFetcher *)fetcher finishedWithData:(NSData *)retrievedData error:(NSError *)error {
    
    if (error != nil) {
        NSLog(@"%@", [error description]);
    } else {
        NSString *output = [[[NSString alloc] initWithData:retrievedData encoding:NSUTF8StringEncoding] autorelease];
        //NSLog(@"%@", output);
        self.responseTextView.text = output;
    
        /* json
        NSDictionary *nickname = [[output JSONValue] objectForKey:@"nickname"];
        NSLog(@"nickname: %@", nickname);
        */
        
        /* json
        NSDictionary *user = [[output JSONValue] objectForKey:@"user"];
        NSString *user_name = [user objectForKey:@"name"];
        */
    }
}

- (IBAction)oAuthLoginButton:(id)sender
{
    self.accessTokenTextView.text = @"...";
    self.responseTextView.text = @"...";
    [self signInToCustom];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
