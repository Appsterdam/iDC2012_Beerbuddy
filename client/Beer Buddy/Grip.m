//
//  Grip.m
//  Beer Buddy
//
//  Created by Paul Wagener on 21-07-12.
//  Copyright (c) 2012 Paul Wagener. All rights reserved.
//

#import "Grip.h"

@implementation Grip

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {

}

/**
 * Plaats grip & grafiek constant terwijl de gebruik aan het draggen is
 */
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:container];
    
    cover.frame = CGRectMake(cover.frame.origin.x, point.y-cover.frame.size.height, cover.frame.size.width, cover.frame.size.height);
}

/**
 * Plaats Grip & Grafiek op een juiste eindpositie na de drag van de gebruiker
 */
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    // Bepaal of grafiek zichtbaar moet worden of niet gebaseerd of gebruiker omhoog of omlaag aan het scrollen was
    UITouch *touch = [touches anyObject];
    const CGPoint location = [touch locationInView:self];
    const CGPoint previousLocation = [touch previousLocationInView:self];
    const CGFloat inertia = location.y - previousLocation.y;
    bool zichtbaar = inertia >= 0;
    
    [UIView animateWithDuration:0.4 animations:^{
        cover.frame = CGRectMake(cover.frame.origin.x, zichtbaar ? 0 : self.frame.size.height - cover.frame.size.height, cover.frame.size.width, cover.frame.size.height);
    }];
}

@end
