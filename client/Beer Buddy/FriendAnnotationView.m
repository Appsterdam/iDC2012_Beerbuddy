//
//  FriendAnnotationView.m
//  Beer Buddy
//
//  Created by Paul Wagener on 21-07-12.
//  Copyright (c) 2012 Paul Wagener. All rights reserved.
//

#import "FriendAnnotationView.h"

@implementation FriendAnnotationView

#define FRIENDVIEW_WIDTH 70
#define FRIENDVIEW_WIDTH_EXPANDED 250
#define FRIENDVIEW_HEIGHT 70

- (id)initWithFriend:(Friend*)aFriend
{
    self = [super init];
    self->friend = aFriend;
    
    [[NSBundle mainBundle] loadNibNamed:@"FriendAnnotationView" owner:self options:nil];
    [self addSubview:view];
    
    // Fill information
    nameLabel.text = friend->name;
    nearLabel.text = friend->near;
    
    
    // Set frame size
    self.centerOffset = CGPointMake(0, -FRIENDVIEW_WIDTH/2);
    self.frame = CGRectMake(0, 0, FRIENDVIEW_WIDTH, FRIENDVIEW_HEIGHT);
    view.frame = self.frame;

    
    // Catch taps
    [self setEnabled:NO];
    self.userInteractionEnabled = YES;
    
    tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    tapGestureRecognizer.delegate = self;
    [self addGestureRecognizer:tapGestureRecognizer];
    folded = true;
    return self;
}

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
        self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, FRIENDVIEW_WIDTH_EXPANDED, FRIENDVIEW_HEIGHT);
        view.frame = CGRectMake(view.frame.origin.x, view.frame.origin.y, FRIENDVIEW_WIDTH_EXPANDED, FRIENDVIEW_HEIGHT);
        extraStuff.alpha = 1.0;
        self.centerOffset = CGPointMake((FRIENDVIEW_WIDTH_EXPANDED-FRIENDVIEW_WIDTH)/2, -FRIENDVIEW_HEIGHT/2);
    }];
}

- (void) foldin {
    [UIView animateWithDuration:0.3 animations:^{
        self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, FRIENDVIEW_WIDTH, FRIENDVIEW_HEIGHT);
        view.frame = CGRectMake(view.frame.origin.x, view.frame.origin.y, FRIENDVIEW_WIDTH, FRIENDVIEW_HEIGHT);
        extraStuff.alpha = 0.0;
        self.centerOffset = CGPointMake(0, -FRIENDVIEW_HEIGHT/2);
    }];
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer 
       shouldReceiveTouch:(UITouch *)touch {
    return YES;
}

@end
