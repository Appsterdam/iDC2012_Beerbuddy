//
//  FriendListTableViewController.h
//  Beer Buddy
//
//  Created by Paul Wagener on 22-07-12.
//  Copyright (c) 2012 Paul Wagener. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FriendListTableViewController : UIViewController<UITableViewDelegate, UITableViewDataSource> {
    NSArray *friends;
}

- (void) setFriends:(NSArray*)friends;
- (IBAction) close:(id)sender;
@end
