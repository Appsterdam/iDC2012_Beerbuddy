//
//  ViewController.m
//  Beer Buddy
//
//  Created by Paul Wagener on 21-07-12.
//  Copyright (c) 2012 Paul Wagener. All rights reserved.
//

#import "ViewController.h"
#import "FriendAnnotation.h"
#import "FriendAnnotationView.h"
#import "Facebook.h"
#import "AppDelegate.h"
@implementation ViewController

- (void)viewDidLoad
{
    facebook = [[Facebook alloc] initWithAppId:@"206562152806303" andDelegate:self];
    AppDelegate *del = [UIApplication sharedApplication].delegate;
    del->facebook = facebook;
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if ([defaults objectForKey:@"FBAccessTokenKey"] 
        && [defaults objectForKey:@"FBExpirationDateKey"]) {
        facebook.accessToken = [defaults objectForKey:@"FBAccessTokenKey"];
        facebook.expirationDate = [defaults objectForKey:@"FBExpirationDateKey"];
    }
    
    if(![facebook isSessionValid])
        [facebook authorize:[NSArray arrayWithObject:@"user_about_me"]];
    
    [super viewDidLoad];

    FriendAnnotation *annotation = [[FriendAnnotation alloc] initWithCoordinate:CLLocationCoordinate2DMake(52.366667, 4.9)];

    [mapview addAnnotation:annotation];
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation {
    return [[FriendAnnotationView alloc] init];
}

/**
 * Called when the user successfully logged in.
 */
- (void)fbDidLogin {
    NSLog(@"Access token: %@", facebook.accessToken);
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:[facebook accessToken] forKey:@"FBAccessTokenKey"];
    [defaults setObject:[facebook expirationDate] forKey:@"FBExpirationDateKey"];
    [defaults synchronize];
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
    NSLog(@"Got token: %@", accessToken);
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

@end
