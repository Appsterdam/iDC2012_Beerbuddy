//
//  PreferencesViewController.m

#import "PreferencesViewController.h"

@implementation PreferencesViewController


#pragma mark ACTION BUTTON

-(IBAction) done:(id)sender {
	NSLog(@"-- CLOSE PREFERENCES --\n");
    if ([self respondsToSelector:@selector(presentingViewController)])
        //self.newController = modalViewController.presentingViewController;
        [[self presentingViewController] dismissModalViewControllerAnimated:YES];
    else
        //self.newController = modalViewController.parentViewController;
        [[self parentViewController] dismissModalViewControllerAnimated:YES];
}

#pragma mark LOAD VIEW

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //[self layoutForCurrentOrientation:NO];
}


- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    //return ((interfaceOrientation == UIInterfaceOrientationPortrait) || (interfaceOrientation == UIInterfaceOrientationLandscapeLeft) || (interfaceOrientation == UIInterfaceOrientationLandscapeRight));
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}



@end