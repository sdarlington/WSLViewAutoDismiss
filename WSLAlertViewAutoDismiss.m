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


@implementation WSLAlertViewAutoDismiss  {
    void(^delegateBlock)(NSInteger);
    void(^cancelBlock)();
}

- (id)init {
    self = [super init];
    if (self) {
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
    
    self = [super initWithTitle:title message:message delegate:self cancelButtonTitle:cancelButtonTitle otherButtonTitles:nil, nil];
    if (self) {
        delegateBlock = action; // do I need to copy?!
        cancelBlock = cancel;
        
        va_list args;
        va_start(args, otherButtonTitles);
        for (NSString *anOtherButtonTitle = otherButtonTitles; anOtherButtonTitle != nil; anOtherButtonTitle = va_arg(args, NSString*)) {
            [self addButtonWithTitle:anOtherButtonTitle];
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
        if (cancelBlock) {
            cancelBlock();
        }
    }
    else {
        if (delegateBlock) {
            delegateBlock(buttonIndex);
        }
    }
}

@end
