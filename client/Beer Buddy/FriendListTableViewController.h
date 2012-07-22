//
//  FriendListTableViewController.h
//  Beer Buddy
//
//  Created by Paul Wagener on 22-07-12.
//  Copyright (c) 2012 Paul Wagener. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FriendListTableViewController : UITableViewController<UITableViewDelegate, UITableViewDataSource> {
    
}

- (id) initWithFriends:(NSArray*)friends;

@end
