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

@interface MainViewController ()<UIAlertViewDelegate,UIActionSheetDelegate>

@property (strong, nonatomic) IBOutlet UISwitch *blocksSwitch;
@property (strong, nonatomic) IBOutlet UILabel *statusLabel;

@end

@implementation MainViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.blocksSwitch.on = YES;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (IBAction)showAlertView:(id)sender {
    WSLAlertViewAutoDismiss* alert;
    if (self.blocksSwitch.on) {
        __weak typeof(self) weakSelf = self;
        alert = [[WSLAlertViewAutoDismiss alloc] initWithTitle:@"Test"
                                                       message:@"A test message"
                                                        action:^(NSInteger b){
                                                            weakSelf.statusLabel.text = [NSString stringWithFormat:@"Tapped: %ld", (long)b];
                                                        }
                                                  cancelAction:^{}
                                             cancelButtonTitle:@"Cancel"
                                             otherButtonTitles:@"Test", @"Test 2", @"Test 3", nil];
    }
    else {
        alert = [[WSLAlertViewAutoDismiss alloc] initWithTitle:@"Test"
                                                       message:@"A test message"
                                                      delegate:self
                                             cancelButtonTitle:@"Cancel"
                                             otherButtonTitles:@"Test", @"Test 2", @"Test 3", nil];
    }
    [alert show];
}

- (IBAction)showActionSheet:(id)sender {
    WSLActionSheetAutoDismiss* sheet;
    if (self.blocksSwitch) {
        __weak typeof(self) weakSelf = self;
        sheet = [[WSLActionSheetAutoDismiss alloc] initWithTitle:@"Test"
                                                          action:^(NSInteger b) {
                                                              weakSelf.statusLabel.text = [NSString stringWithFormat:@"Tapped: %ld", (long)b];
                                                          }
                                               cancelButtonTitle:@"Cancel"
                                          destructiveButtonTitle:@"Danger!"
                                               otherButtonTitles:@"Not dangerous",nil];
    }
    else {
        sheet = [[WSLActionSheetAutoDismiss alloc] initWithTitle:@"Test"
                                                        delegate:self
                                               cancelButtonTitle:@"Cancel"                                         destructiveButtonTitle:@"Danger!"
                                               otherButtonTitles:@"Not dangerous", nil];
    }
    [sheet showInView:self.view];
}

#pragma mark - UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    self.statusLabel.text = [NSString stringWithFormat:@"Tapped: %ld", (long)buttonIndex];
}

#pragma mark - UIActionSheetDelegate

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    self.statusLabel.text = [NSString stringWithFormat:@"Tapped: %ld", (long)buttonIndex];
}

@end
