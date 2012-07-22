//
//  ViewController.h
//  Beer Buddy
//
//  Created by Paul Wagener on 21-07-12.
//  Copyright (c) 2012 Paul Wagener. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "Facebook.h"
#import "Friend.h"

//#import "Grip.h"

@class Friend;


@interface ViewController : UIViewController<MKMapViewDelegate> { //,contentViewDelegate
    Facebook *facebook;
    IBOutlet MKMapView *mapview;
    IBOutlet UIView *activityThrobber;
    NSMutableArray *friends;
}


- (IBAction) showList:(id)sender;
- (void)foldinAllAnnotationsExcept:(Friend*)exceptFriend;

@end
