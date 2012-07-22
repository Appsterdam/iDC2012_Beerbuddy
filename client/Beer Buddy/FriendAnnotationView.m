//
//  FriendAnnotationView.m
//  Beer Buddy
//
//  Created by Paul Wagener on 21-07-12.
//  Copyright (c) 2012 Paul Wagener. All rights reserved.
//

#import "FriendAnnotationView.h"
#import "ViewController.h"
@implementation FriendAnnotationView

#define FRIENDVIEW_WIDTH 70
#define FRIENDVIEW_WIDTH_EXPANDED 200
#define FRIENDVIEW_HEIGHT 70

- (id)initWithFriend:(Friend*)aFriend:(ViewController*)aViewController;
{
    self = [super init];
    self->friend = aFriend;
    self->viewController = aViewController;
    friend->view = self;
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:friend->image_link]];
        dispatch_async(dispatch_get_main_queue(), ^{
            friend->image = [UIImage imageWithData:data];
            imageView.image = friend->image;
        });
    });
    
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
}

- (void) foldout {
    
    [UIView animateWithDuration:0.3 animations:^{
        self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, FRIENDVIEW_WIDTH_EXPANDED, FRIENDVIEW_HEIGHT);
        view.frame = CGRectMake(view.frame.origin.x, view.frame.origin.y, FRIENDVIEW_WIDTH_EXPANDED, FRIENDVIEW_HEIGHT);
        extraStuff.alpha = 1.0;
        self.centerOffset = CGPointMake((FRIENDVIEW_WIDTH_EXPANDED-FRIENDVIEW_WIDTH)/2, -FRIENDVIEW_HEIGHT/2);
    }];
    [viewController foldinAllAnnotationsExcept:friend];
    folded = NO;
}

- (void) foldin {
    [UIView animateWithDuration:0.3 animations:^{
        self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, FRIENDVIEW_WIDTH, FRIENDVIEW_HEIGHT);
        view.frame = CGRectMake(view.frame.origin.x, view.frame.origin.y, FRIENDVIEW_WIDTH, FRIENDVIEW_HEIGHT);
        extraStuff.alpha = 0.0;
        self.centerOffset = CGPointMake(0, -FRIENDVIEW_HEIGHT/2);
    }];
    folded = YES;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer 
       shouldReceiveTouch:(UITouch *)touch {
    return YES;
}

@end
