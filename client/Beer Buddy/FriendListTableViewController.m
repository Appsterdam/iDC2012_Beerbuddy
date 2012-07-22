//
//  FriendListTableViewController.m
//  Beer Buddy
//
//  Created by Paul Wagener on 22-07-12.
//  Copyright (c) 2012 Paul Wagener. All rights reserved.
//

#import "FriendListTableViewController.h"
#import "Friend.h"
@implementation FriendListTableViewController


- (void) setFriends:(NSArray*)theFriends {
    friends = theFriends;
}

- (IBAction) close:(id)sender {
    [self dismissModalViewControllerAnimated:YES];
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
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    Friend *friend = [friends objectAtIndex:indexPath.row];
    cell.textLabel.text = friend->name;
    cell.imageView.image = friend->image;
    
    return cell;
}


@end
