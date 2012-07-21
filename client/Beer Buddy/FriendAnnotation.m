//
//  FriendAnnotation.m
//  Beer Buddy
//
//  Created by Paul Wagener on 21-07-12.
//  Copyright (c) 2012 Paul Wagener. All rights reserved.
//

#import "FriendAnnotation.h"

@implementation FriendAnnotation
@synthesize coordinate;

- (NSString *)subtitle{
    return @"Subtitle";
}
- (NSString *)title{
    return @"Title";
}
-(id)initWithCoordinate:(CLLocationCoordinate2D) c{
    coordinate=c;
    return self;
}


@end
