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

    NSDictionary *location = [dictionary objectForKey:@"location"];
    
    NSNumber *latitude = [location objectForKey:@"lat"];
    NSNumber *longitude = [dictionary objectForKey:@"lon"];
    coordinate = CLLocationCoordinate2DMake(latitude.floatValue, longitude.floatValue);
    name = [dictionary objectForKey:@"first_name"];
    near = [dictionary objectForKey:@"near"];
    image_link = [dictionary objectForKey:@"photo"];
    
    return self;
}

@end
