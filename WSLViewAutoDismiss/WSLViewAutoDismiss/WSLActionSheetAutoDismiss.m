/*
 * Copyright 2010-12 Stephen Darlington, Wandle Software Limited
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#import "WSLActionSheetAutoDismiss.h"


NSString* const WSLActionSheetAutoDismissLaunchedNotification = @"WSLActionSheetAutoDismissLaunchedNotification";

@implementation WSLActionSheetAutoDismiss

- (void)processVaArgsWithTitle:(NSString*)title list:(va_list)list {
    for (NSString *buttonTitle = title; buttonTitle != nil; buttonTitle = va_arg(list, NSString*)) {
        [self addButtonWithTitle:buttonTitle];
    }
}

- (id)initWithTitle:(NSString *)title delegate:(id<UIActionSheetDelegate>)delegate cancelButtonTitle:(NSString *)cancelButtonTitle destructiveButtonTitle:(NSString *)destructiveButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ... {
    self = [super initWithTitle:title delegate:delegate cancelButtonTitle:cancelButtonTitle destructiveButtonTitle:destructiveButtonTitle otherButtonTitles:nil];
    if (self) {
        if (otherButtonTitles) {
            va_list args;
            va_start(args, otherButtonTitles);
            [self processVaArgsWithTitle:otherButtonTitles list:args];
            va_end(args);
        }
        
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
            [nc postNotificationName:WSLActionSheetAutoDismissLaunchedNotification object:self];
            [nc addObserver:self
                   selector:@selector(cancelActionSheet:)
                       name:WSLActionSheetAutoDismissLaunchedNotification
                     object:nil];
        }
    }
    return self;
}

- (id)initWithTitle:(NSString *)title
             action:(void(^)(NSInteger)) action
  cancelButtonTitle:(NSString *)cancelButtonTitle
destructiveButtonTitle:(NSString *)destructiveButtonTitle
  otherButtonTitles:(NSString *)otherButtonTitles, ... {
    
    self = [self initWithTitle:title delegate:self cancelButtonTitle:cancelButtonTitle destructiveButtonTitle:destructiveButtonTitle otherButtonTitles:nil, nil];
    if (self) {
        _actionBlock = action;
        
        va_list args;
        va_start(args, otherButtonTitles);
        [self processVaArgsWithTitle:otherButtonTitles list:args];
        va_end(args);
    }
    return self;
}

- (void) dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void) cancelActionSheet:(id) sender {
    // We should not be here when entering back to foreground state
    [self dismissWithClickedButtonIndex:[self cancelButtonIndex] animated:NO];
}

#pragma mark - UIActionSheetDelegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (self.actionBlock) {
        self.actionBlock(buttonIndex);
    }
}

@end
