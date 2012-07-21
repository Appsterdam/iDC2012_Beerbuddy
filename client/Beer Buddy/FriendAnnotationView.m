//
//  FriendAnnotationView.m
//  Beer Buddy
//
//  Created by Paul Wagener on 21-07-12.
//  Copyright (c) 2012 Paul Wagener. All rights reserved.
//

#import "FriendAnnotationView.h"

@implementation FriendAnnotationView

- (id)init
{
    self = [super init];
    [[NSBundle mainBundle] loadNibNamed:@"FriendAnnotationView" owner:self options:nil];
    [self addSubview:view];
    
    self.centerOffset = CGPointMake(-view.frame.size.width/2, -view.frame.size.height);
    NSLog(@"%@", view);
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
