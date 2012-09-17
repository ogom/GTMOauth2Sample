Google Toolbox for Mac - OAuth 2 Controllers Sample
===================================================

Sample to use oauth in iOS.


## Installation

### New Project
* Choose a template for `Single View Application`.
* Product Name is `GTMOauth2Sample`.

### Download

    $ cd ./GTMOauth2Sample
    $ rm -rf ./.git/
    $ svn checkout http://gtm-oauth2.googlecode.com/svn/trunk/ ./Library
    $ cd ./Library/
    $ mv ./Source/ ./GTMOAuth2/
    $ rm -rf ./.svn/
    $ rm -rf ./GTMOAuth2/.svn/
    $ rm -rf ./GTMOAuth2/Mac/.svn/
    $ rm -rf ./GTMOAuth2/Touch/.svn/
    $ rm -rf ./GTMOAuth2/GTMOAuth2.xcodeproj/
    $ rm -f  ./GTMOAuth2/ReleaseNotes.txt
    $ rm -rf ./HTTPFetcher/.svn/
    $ rm -rf ./HTTPFetcher/GTMHTTPFetcher.xcodeproj/
    $ rm -rf ./HTTPFetcher/Tests/
    $ rm -f  ./HTTPFetcher/ReleaseNotes.txt
    $ rm -f  ./HTTPFetcher/UnitTests-Info.plist
    $ rm -rf ./JSON/.svn/
    $ rm -rf ./Examples/

###　Add file
* Add a files to the `GTMOauth2Sample` to `Library`.

### Build
* ON the `Objecctive-C Automatic Refarence Counting` of the `Apple LLVM compiler 4.0 – Language` in `Build Settings`
* Add to `SystemConfiguration.framework` and `Security.framework` of `Build Phases` to `Link Binary With Libaries`


## Uses
* [Google Toolbox for Mac - OAuth 2 Controllers](http://code.google.com/p/gtm-oauth2/)
