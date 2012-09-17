//
//  ViewController.h
//  GTMOauth2Sample
//
//  Created by ogom on 12/09/16.
//  Copyright (c) 2012 ogom. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

- (IBAction)oAuthLoginButton:(id)sender;

@property(retain, nonatomic) IBOutlet UITextView *accessTokenTextView;
@property(retain, nonatomic) IBOutlet UITextView *responseTextView;

@end
