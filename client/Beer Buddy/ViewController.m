//
//  ViewController.m
//  Beer Buddy
//
//  Created by Paul Wagener on 21-07-12.
//  Copyright (c) 2012 Paul Wagener. All rights reserved.
//

#import "ViewController.h"
#import "FriendAnnotation.h"


@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    FriendAnnotation *annotation = [[FriendAnnotation alloc] initWithCoordinate:CLLocationCoordinate2DMake(52.366667, 4.9)];

    [mapview addAnnotation:annotation];
}

@end
