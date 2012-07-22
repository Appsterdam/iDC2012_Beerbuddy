//
//  FacebookLoginViewController.h
//  Beer Buddy
//
//  Created by Paul Wagener on 22-07-12.
//  Copyright (c) 2012 Paul Wagener. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Facebook.h"

@interface FacebookLoginViewController : UIViewController<FBSessionDelegate>
- (IBAction) loginFacebookButton:(id)sender;
@end
