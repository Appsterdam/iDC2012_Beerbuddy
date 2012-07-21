//
//  FriendAnnotationView.h
//  Beer Buddy
//
//  Created by Paul Wagener on 21-07-12.
//  Copyright (c) 2012 Paul Wagener. All rights reserved.
//

#import <MapKit/MapKit.h>
#import "Friend.h"
#import "ViewController.h"
@class Friend;
@class ViewController;

@interface FriendAnnotationView : MKAnnotationView<UIGestureRecognizerDelegate> {
    IBOutlet UIView *view;
    UITapGestureRecognizer *tapGestureRecognizer;
    IBOutlet UIView *extraStuff;
    IBOutlet UILabel *nameLabel;
    IBOutlet UILabel *nearLabel;
    bool folded;
    Friend *friend;
    ViewController *viewController;
}

- (id)initWithFriend:(Friend*)friend :(ViewController*)viewController;
- (void) foldin;
@end
