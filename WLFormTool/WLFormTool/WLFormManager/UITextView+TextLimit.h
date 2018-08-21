//
//  UITextView+TextLimit.h
//  WLFormTool
//
//  Created by Self.impr on 2018/8/15.
//  Copyright © 2018 bestlei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextView (TextLimit)

/**
 TextView 添加字数限制

 @param maxLength 限制字数
 */
- (void)textLimitWithMaxLength:(NSInteger)maxLength;

@end
