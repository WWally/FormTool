//
//  UITextField+TextLimit.m
//  WLFormTool
//
//  Created by Self.impr on 2018/8/15.
//  Copyright © 2018 bestlei. All rights reserved.
//

#import "UITextField+TextLimit.h"

@implementation UITextField (TextLimit)

- (void)textLimitWithMaxLength:(NSInteger)maxLength {
    NSString *toBeString = self.text;
    NSArray *inputModes = [UITextInputMode activeInputModes];
    UITextInputMode *currentMode = [inputModes firstObject];
    
    // 输入内容中文校验
    if ([currentMode.primaryLanguage isEqualToString:@"zh-Hans"]) {
        UITextRange *selectedRange = [self markedTextRange];
        UITextPosition *position = [self positionFromPosition:selectedRange.start offset:0];
        if (!position) {
            if (toBeString.length > maxLength) {
                self.text = [toBeString substringToIndex:maxLength];
            }
        }
    }
    else{
        if (toBeString.length > maxLength) {
            self.text = [toBeString substringToIndex:maxLength];
        }
    }
}
@end
