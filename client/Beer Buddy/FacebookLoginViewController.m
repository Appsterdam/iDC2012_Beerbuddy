//
//  FacebookLoginViewController.m
//  Beer Buddy
//
//  Created by Paul Wagener on 22-07-12.
//  Copyright (c) 2012 Paul Wagener. All rights reserved.
//

#import "FacebookLoginViewController.h"
#import "AppDelegate.h"

@implementation FacebookLoginViewController

- (void)viewDidAppear:(BOOL)animated
{
    AppDelegate *delegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
    delegate->facebook = [[Facebook alloc] initWithAppId:@"206562152806303" andDelegate:self];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if ([defaults objectForKey:@"FBAccessTokenKey"] 
        && [defaults objectForKey:@"FBExpirationDateKey"]) {
        delegate->facebook.accessToken = [defaults objectForKey:@"FBAccessTokenKey"];
        delegate->facebook.expirationDate = [defaults objectForKey:@"FBExpirationDateKey"];
        
        [self gotoMainScreen];
        return;
    }
    
    if(![delegate->facebook isSessionValid])
        [self loginFacebookButton:nil];
}

- (void) gotoMainScreen {
    UIViewController *mainScreen = [self.storyboard instantiateViewControllerWithIdentifier:@"main"];
    [self presentModalViewController:mainScreen animated:YES];
}

- (IBAction) loginFacebookButton:(id)sender {
    AppDelegate *delegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
    [delegate->facebook authorize:[NSArray arrayWithObject:@"user_about_me"]];
}

/**
 * Called when the user dismissed the dialog without logging in.
 */
- (void)fbDidNotLogin:(BOOL)cancelled {
    
}

/**
 * Called after the access token was extended. If your application has any
 * references to the previous access token (for example, if your application
 * stores the previous access token in persistent storage), your application
 * should overwrite the old access token with the new one in this method.
 * See extendAccessToken for more details.
 */
- (void)fbDidExtendToken:(NSString*)accessToken
               expiresAt:(NSDate*)expiresAt {
}

/**
 * Called when the user logged out.
 */
- (void)fbDidLogout {
    
}

/**
 * Called when the current session has expired. This might happen when:
 *  - the access token expired
 *  - the app has been disabled
 *  - the user revoked the app's permissions
 *  - the user changed his or her password
 */
- (void)fbSessionInvalidated {
    
}

/**
 * Called when the user successfully logged in.
 */
- (void)fbDidLogin {
    Facebook *facebook = ((AppDelegate*)[UIApplication sharedApplication].delegate)->facebook;
    
    NSLog(@"Access token: %@", facebook.accessToken);
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:[facebook accessToken] forKey:@"FBAccessTokenKey"];
    [defaults setObject:[facebook expirationDate] forKey:@"FBExpirationDateKey"];
    [defaults synchronize];
    
    [self gotoMainScreen];
}

@end
