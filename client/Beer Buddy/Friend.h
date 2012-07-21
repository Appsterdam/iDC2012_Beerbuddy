//
//  Friend.h
//  Beer Buddy
//
//  Created by Paul Wagener on 21-07-12.
//  Copyright (c) 2012 Paul Wagener. All rights reserved.
//

#import <MapKit/MapKit.h>
#import "FriendAnnotationView.h"

@class FriendAnnotationView;

@interface Friend : NSObject<MKAnnotation> {
    @public
    NSString *name;
    NSString *near;
    
    FriendAnnotationView *view;
}

- (id) initWithDictionary:(NSDictionary*)dictionary;
@end
