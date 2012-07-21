//
//  FriendAnnotationView.h
//  Beer Buddy
//
//  Created by Paul Wagener on 21-07-12.
//  Copyright (c) 2012 Paul Wagener. All rights reserved.
//

#import <MapKit/MapKit.h>
#import "Friend.h"

@interface FriendAnnotationView : MKAnnotationView<UIGestureRecognizerDelegate> {
    IBOutlet UIView *view;
    UITapGestureRecognizer *tapGestureRecognizer;
    IBOutlet UIView *extraStuff;
    
    Friend *friend;
}

@end
