//
//  InfoViewController.h
//  Flip Face
//
//  Created by Pizzichemi Marco on 21/01/2011.
//  Copyright 2011 - All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PreferencesViewController : UIViewController{
    
    IBOutlet UISwitch *switch1;
    IBOutlet UISwitch *switch2;
}

@property(nonatomic, retain) IBOutlet UISwitch *switch1;
@property(nonatomic, retain) IBOutlet UISwitch *switch2;

- (IBAction) done:(id)sender;


@end
