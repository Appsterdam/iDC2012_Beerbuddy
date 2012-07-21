//
//  FriendAnnotation.m
//  Beer Buddy
//
//  Created by Paul Wagener on 21-07-12.
//  Copyright (c) 2012 Paul Wagener. All rights reserved.
//

#import "FriendAnnotation.h"
#import "Friend.h"

@implementation FriendAnnotation
@synthesize coordinate;

-(id)initWithFriend:(Friend*)friend {
    coordinate=friend->coordinate;
    return self;
}


@end
