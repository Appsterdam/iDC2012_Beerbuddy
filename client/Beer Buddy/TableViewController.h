//
//  TableViewController.h
//
//  Created by Marco Pizzichemi on 30/06/12.
//  Copyright (c) 2012 -. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "DetailsViewController.h"

@interface TableViewController : UINavigationController <UITableViewDelegate, UITableViewDataSource>{
    
    IBOutlet UITableView *tableView;
    
    DetailsViewController *detailController;
}

@property (retain) NSArray *people;
@property (retain) IBOutlet UITableView *tableView;


@end
