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
    
    self.centerOffset = CGPointMake(0, -50);
    self.frame = CGRectMake(0, 0, 100, 100);
    view.frame = self.frame;
    self.backgroundColor = [UIColor greenColor];

    [self setEnabled:NO];
    self.userInteractionEnabled = YES;
    
    tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    tapGestureRecognizer.delegate = self;
    [self addGestureRecognizer:tapGestureRecognizer];

    return self;
}

bool folded = true;
- (void)handleTap:(id)sender {
    if(folded)
        [self foldout];
    else {
        [self foldin];
    }
    folded = !folded;
}

- (void) foldout {
    
    [UIView animateWithDuration:0.3 animations:^{
        self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, 200, 100);
        view.frame = CGRectMake(view.frame.origin.x, view.frame.origin.y, 200, 100);
        extraStuff.alpha = 1.0;
        self.centerOffset = CGPointMake(50, -50);
    }];
}

- (void) foldin {
    [UIView animateWithDuration:0.3 animations:^{
        self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, 100, 100);
        view.frame = CGRectMake(view.frame.origin.x, view.frame.origin.y, 100, 100);
        extraStuff.alpha = 0.0;
        self.centerOffset = CGPointMake(0, -50);
    }];
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer 
       shouldReceiveTouch:(UITouch *)touch {
    return YES;
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
