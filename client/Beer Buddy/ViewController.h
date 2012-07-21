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
@interface ViewController : UIViewController<MKMapViewDelegate, FBSessionDelegate> {
    Facebook *facebook;
    IBOutlet MKMapView *mapview;
    IBOutlet UIView *activityThrobber;
}

@end
