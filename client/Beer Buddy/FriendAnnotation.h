//
//  FriendAnnotation.h
//  Beer Buddy
//
//  Created by Paul Wagener on 21-07-12.
//  Copyright (c) 2012 Paul Wagener. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface FriendAnnotation : NSObject<MKAnnotation> {
    
}

-(id)initWithCoordinate:(CLLocationCoordinate2D) c;

@end
