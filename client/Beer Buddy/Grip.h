//
//  Grip.h
//  Beer Buddy
//
//  Created by Paul Wagener on 21-07-12.
//  Copyright (c) 2012 Paul Wagener. All rights reserved.
//

#import <UIKit/UIKit.h>

//@protocol contentViewDelegate;

@interface Grip : UIView {
    
    //id <contentViewDelegate> contentDelegate;
    
    IBOutlet UIView *container;
    IBOutlet UIView *cover;
    
    IBOutlet UIImageView *TitleImage;
    
    IBOutlet UIButton *But_MapList;
    IBOutlet UIButton *But_Preferences;
    
    IBOutlet UIView *gripLabel;
}

//@property(nonatomic, assign) id <contentViewDelegate> contentDelegate;

@property(nonatomic, retain) IBOutlet UIImageView *TitleImage;

@property(nonatomic, retain) IBOutlet UIButton *But_MapList;
@property(nonatomic, retain) IBOutlet UIButton *But_Preferences;

@property(nonatomic, retain) IBOutlet UIView *gripLabel;

-(IBAction)showPreferences:(id) sender;
-(IBAction)showTable:(id) sender;

@end


//-------------------------------------------------//
/*@protocol contentViewDelegate
    - (void) showPreferences;
@end*/


