//
//  FriendListTableViewController.m
//  Beer Buddy
//
//  Created by Paul Wagener on 22-07-12.
//  Copyright (c) 2012 Paul Wagener. All rights reserved.
//

#import "FriendListTableViewController.h"

@interface FriendListTableViewController ()

@end

@implementation FriendListTableViewController

NSArray *friends;
- (id) initWithFriends:(NSArray*)theFriends {
    friends = theFriends;
    self = [self init];
    return self;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return friends.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"FriendCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    cell.textLabel.text = @"Test";
    
    return cell;
}


@end
