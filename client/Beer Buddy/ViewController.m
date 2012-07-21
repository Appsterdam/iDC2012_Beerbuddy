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
#import "JSONKit.h"
#import "Friend.h"
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
        [self loadData:facebook.accessToken];
    }
    
    if(![facebook isSessionValid])
        [facebook authorize:[NSArray arrayWithObject:@"user_about_me"]];
    
    [super viewDidLoad];
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation {
    return [[FriendAnnotationView alloc] initWithFriend:(Friend*)annotation];
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
    
    [self loadData:facebook.accessToken];
}

- (void) loadData:(NSString*)accessToken {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://10.0.0.169/Sites/json.txt?accesstoken=%@",accessToken]];
        
        NSString *json = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil];
        
        JSONDecoder *jsonDecoder = [JSONDecoder decoder]; 
        NSArray *friendsDictionaries = [jsonDecoder objectWithUTF8String:(const unsigned char*)json.UTF8String length:json.length];
        
        NSMutableArray *friends = [[NSMutableArray alloc] init];
        
        for(NSDictionary *friendDictionary in friendsDictionaries) {
            Friend *friend = [[Friend alloc] initWithDictionary:friendDictionary];
            [friends addObject:friend];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [mapview addAnnotations:friends];    
            [UIView animateWithDuration:1 animations:^{
                activityThrobber.alpha = 0;
            }];
        });
    });
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

@end
