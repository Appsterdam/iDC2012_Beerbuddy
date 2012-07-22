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


- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation {
    return [[FriendAnnotationView alloc] initWithFriend:(Friend*)annotation:self];
}

- (void)foldinAllAnnotationsExcept:(Friend*)exceptFriend {
    for(Friend *friend in friends) {
        if(friend != exceptFriend) {
            [friend->view foldin];
        }
    }
}
- (void)viewDidLoad
{
    friends = [[NSMutableArray alloc] init];
    
    // The fact that this is view is loaded means that we have access to the access token
    AppDelegate *delegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
    [self loadData:delegate->facebook.accessToken];
    
}   

-(IBAction) facebookDisconnect:(id)sender {
    AppDelegate *delegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
    [delegate->facebook logout];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults removeObjectForKey:@"FBAccessTokenKey"];
    [defaults removeObjectForKey:@"FBExpirationDateKey"];
    [defaults synchronize];
    
    [self dismissModalViewControllerAnimated:YES];
}

#import "FriendListTableViewController.h"

- (IBAction) showList:(id)sender {
    FriendListTableViewController *listView = [self.storyboard instantiateViewControllerWithIdentifier:@"list"];
    listView = [listView initWithFriends:friends];
    
    [self presentModalViewController:listView animated:YES];
}

- (IBAction)handleMapTap:(id)sender {
    [self foldinAllAnnotationsExcept:nil];
}


- (void) loadData:(NSString*)accessToken {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://beerbuddy.herokuapp.com/login?access_token=%@&lat=52.373056&lon=4.892222",accessToken]];
        
        NSLog(@"Access Token: %@", accessToken);
        
        NSString *json = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil];
        
        JSONDecoder *jsonDecoder = [JSONDecoder decoder]; 
        NSDictionary *rootDictionary = [jsonDecoder objectWithUTF8String:(const unsigned char*)json.UTF8String length:json.length];
        
        NSArray *friendsDictionaries = [rootDictionary objectForKey:@"beer_buddies"];
        
        
        
        [mapview removeAnnotations:friends];
        friends = [[NSMutableArray alloc] init];
        
        for(NSDictionary *friendDictionary in friendsDictionaries) {
            Friend *friend = [[Friend alloc] initWithDictionary:friendDictionary];
            [friends addObject:friend];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [mapview addAnnotations:friends];
            [self zoomToFitMapAnnotations:mapview];
            
            [UIView animateWithDuration:1 animations:^{
                activityThrobber.alpha = 0;
            }];
        });
    });
}

- (void)zoomToFitMapAnnotations:(MKMapView *)mapView { 
    if ([mapView.annotations count] == 0) return; 
    
    CLLocationCoordinate2D topLeftCoord; 
    topLeftCoord.latitude = -90; 
    topLeftCoord.longitude = 180; 
    
    CLLocationCoordinate2D bottomRightCoord; 
    bottomRightCoord.latitude = 90; 
    bottomRightCoord.longitude = -180; 
    
    for(id<MKAnnotation> annotation in mapView.annotations) { 
        topLeftCoord.longitude = fmin(topLeftCoord.longitude, annotation.coordinate.longitude); 
        topLeftCoord.latitude = fmax(topLeftCoord.latitude, annotation.coordinate.latitude); 
        bottomRightCoord.longitude = fmax(bottomRightCoord.longitude, annotation.coordinate.longitude); 
        bottomRightCoord.latitude = fmin(bottomRightCoord.latitude, annotation.coordinate.latitude); 
    } 
    
    MKCoordinateRegion region; 
    region.center.latitude = topLeftCoord.latitude - (topLeftCoord.latitude - bottomRightCoord.latitude) * 0.5; 
    region.center.longitude = topLeftCoord.longitude + (bottomRightCoord.longitude - topLeftCoord.longitude) * 0.5;      
    region.span.latitudeDelta = fabs(topLeftCoord.latitude - bottomRightCoord.latitude) * 1.1; 
    
    // Add a little extra space on the sides 
    region.span.longitudeDelta = fabs(bottomRightCoord.longitude - topLeftCoord.longitude) * 1.1; 
    
    region = [mapView regionThatFits:region]; 
    [mapView setRegion:region animated:YES]; 
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
