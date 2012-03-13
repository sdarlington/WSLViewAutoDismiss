//
//  WSLMainViewController.m
//  WSLViewAutoDismissDemo
//
//  Created by Stephen Darlington on 22/01/2012.
//  Copyright (c) 2012 Wandle Software Limited. All rights reserved.
//

#import "WSLMainViewController.h"
#import "WSLActionSheetAutoDismiss.h"
#import "WSLAlertViewAutoDismiss.h"

@implementation WSLMainViewController


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (IBAction)actionSheetButton:(id)sender {
    WSLActionSheetAutoDismiss *actionSheet = [[WSLActionSheetAutoDismiss alloc] initWithTitle:NSLocalizedString (@"Are you sure?", @"Are you sure?")
                                                                                       action:^(NSInteger button){
                                                                                           NSLog (@"Pressed button %d", button);
                                                                                       }
                                                                          cancelButtonTitle:NSLocalizedString (@"Cancel", @"Cancel")
                                                                     destructiveButtonTitle:NSLocalizedString(@"Break stuff",@"Break Stuff")
                                                                          otherButtonTitles:nil, nil];
    actionSheet.actionSheetStyle = UIActionSheetStyleDefault;
    actionSheet.destructiveButtonIndex = 0;
    [actionSheet showInView:sender];
}

- (IBAction)alertViewButton:(id)sender {
    WSLAlertViewAutoDismiss* alert = [[WSLAlertViewAutoDismiss alloc] initWithTitle:NSLocalizedString (@"Example", @"Example")
                                                                          message:@"Hello from WSLAlertViewAutoDismiss"
                                                                             action:^(NSInteger button){
                                                                                 NSLog (@"Pressed button %d", button);
                                                                             }
                                                                  cancelButtonTitle:NSLocalizedString (@"Cancel", @"Canecel")
                                                                  otherButtonTitles:NSLocalizedString(@"OK", @"OK"), nil];
    [alert show];
}
                                       
@end
