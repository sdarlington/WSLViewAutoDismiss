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

#import "WSLAlertViewAutoDismiss.h"


@implementation WSLAlertViewAutoDismiss

- (void)processVarArgsWithTitle:(NSString*)title list:(va_list)list {
    for (NSString *buttonTitle = title; buttonTitle != nil; buttonTitle = va_arg(list, NSString*)) {
        [self addButtonWithTitle:buttonTitle];
    }
}

- (id)initWithTitle:(NSString *)title message:(NSString *)message delegate:(id)delegate cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ... {
    self = [super initWithTitle:title message:message delegate:delegate cancelButtonTitle:cancelButtonTitle otherButtonTitles:nil];
    if (self) {
        if (otherButtonTitles) {
            va_list args;
            va_start(args, otherButtonTitles);
            [self processVarArgsWithTitle:otherButtonTitles list:args];
            va_end(args);
        }

        if ([[UIDevice currentDevice].systemVersion intValue] >= 4) {
            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationDidEnterBackground:) name:UIApplicationDidEnterBackgroundNotification object:nil];
        }
    }
    return self;
}

- (id)initWithTitle:(NSString *)title
            message:(NSString *)message
             action:(void(^)(NSInteger))action
       cancelAction:(void(^)(void))cancel
  cancelButtonTitle:(NSString *)cancelButtonTitle
  otherButtonTitles:(NSString *)otherButtonTitles, ...  {
    
    self = [self initWithTitle:title message:message delegate:self cancelButtonTitle:cancelButtonTitle otherButtonTitles:nil, nil];
    if (self) {
        _actionBlock = action;
        _cancelBlock = cancel;
        
        if (otherButtonTitles) {
            va_list args;
            va_start(args, otherButtonTitles);
            [self processVarArgsWithTitle:otherButtonTitles list:args];
            va_end(args);
        }
    }
    return self;
}


- (void) dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void) applicationDidEnterBackground:(id) sender {
    // We should not be here when entering back to foreground state
    [self dismissWithClickedButtonIndex:[self cancelButtonIndex] animated:NO];
}

#pragma mark - UIAlertViewDelegate

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == [alertView cancelButtonIndex]) {
        if (self.cancelBlock) {
            self.cancelBlock();
        }
    }
    else {
        if (self.actionBlock) {
            self.actionBlock(buttonIndex);
        }
    }
}

@end
