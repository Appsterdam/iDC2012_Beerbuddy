//
//  AppDelegate.h
//  Beer Buddy
//
//  Created by Paul Wagener on 21-07-12.
//  Copyright (c) 2012 Paul Wagener. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Facebook.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate> {
    @public
    Facebook *facebook;
}

@property (strong, nonatomic) UIWindow *window;

@end
