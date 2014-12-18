//
//  MainViewController.m
//  AutoDismissDemo
//
//  Created by Stephen Darlington on 21/07/2012.
//  Copyright (c) 2012 Wandle Software Limited. All rights reserved.
//

#import "MainViewController.h"
#import "WSLActionSheetAutoDismiss.h"
#import "WSLAlertViewAutoDismiss.h"

@interface MainViewController ()

@end

@implementation MainViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (IBAction)showAlertView:(id)sender {
    WSLAlertViewAutoDismiss* alert = [[WSLAlertViewAutoDismiss alloc] initWithTitle:@"Test"
                                                                            message:@"A test message"
                                                                             action:^(NSInteger b){}
                                                                       cancelAction:^{}
                                                                  cancelButtonTitle:@"Cancel"
                                                                  otherButtonTitles:@"Test", nil];
    [alert show];
}

- (IBAction)showActionSheet:(id)sender {
    WSLActionSheetAutoDismiss* sheet = [[WSLActionSheetAutoDismiss alloc] initWithTitle:@"Test"
                                                                                 action:^(NSInteger b) {} cancelButtonTitle:@"Cancel"
                                                                 destructiveButtonTitle:@"Danger!"
                                                                      otherButtonTitles:@"Not dangerous",nil];
    [sheet showInView:self.view];
}
@end
