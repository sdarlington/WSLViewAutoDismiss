//
//  UIActionSheetAutoDismissAutoDismiss.m
//
//  Created by Stephen Darlington on 25/07/2010.
//  Copyright 2010 Stephen Darlington. All rights reserved.
//

#import "UIActionSheetAutoDismiss.h"


@implementation UIActionSheetAutoDismiss

- (id)init {
    if (self = [super init]) {
        NSNotificationCenter* nc = [NSNotificationCenter defaultCenter];
        if ([[UIDevice currentDevice].systemVersion intValue] >= 4) {
            // Close ourseleves when the app exits the foreground
            [nc addObserver:self
                   selector:@selector(cancelActionSheet:)
                       name:UIApplicationDidEnterBackgroundNotification
                     object:nil];
        }
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            // Close ourselves when another UIActionSheet opens
            [nc postNotificationName:@"UIActionSheetAutoDismissLaunched" object:self];
            [nc addObserver:self
                   selector:@selector(cancelActionSheet:)
                       name:@"UIActionSheetAutoDismissLaunched"
                     object:nil];
        }
    }
    return self;
}

- (void) dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [super dealloc];
}

- (void) cancelActionSheet:(id) sender {
    // We should not be here when entering back to foreground state
    [self dismissWithClickedButtonIndex:[self cancelButtonIndex] animated:NO];
}

@end
