//
//  Friend.m
//  Beer Buddy
//
//  Created by Paul Wagener on 21-07-12.
//  Copyright (c) 2012 Paul Wagener. All rights reserved.
//

#import "Friend.h"

@implementation Friend
@synthesize coordinate;

- (id)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];

    NSNumber *latitude = [dictionary objectForKey:@"latitude"];
    NSNumber *longitude = [dictionary objectForKey:@"longitude"];
    coordinate = CLLocationCoordinate2DMake(latitude.floatValue, longitude.floatValue);
    name = [dictionary objectForKey:@"name"];
    near = [dictionary objectForKey:@"near"];
    image_link = [dictionary objectForKey:@"photo"];
    
    return self;
}

@end
