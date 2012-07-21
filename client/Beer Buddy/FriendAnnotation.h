//
//  FriendAnnotation.h
//  Beer Buddy
//
//  Created by Paul Wagener on 21-07-12.
//  Copyright (c) 2012 Paul Wagener. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import "Friend.h"

@interface FriendAnnotation : NSObject<MKAnnotation> {
    
}

-(id)initWithFriend:(Friend*) friend;

@end
