//
//  SelwynExpandableTextView.h
//  WLFormTool
//
//  Created by Self.impr on 2018/8/15.
//  Copyright © 2018 bestlei. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 SelwynExpandableTextView 可高度自适应的UITextView
 */
@interface SelwynExpandableTextView : UITextView

@property (nonatomic, assign) NSUInteger currentLength;
@property (nonatomic, assign) NSUInteger maxLength;
@property (nonatomic, assign) BOOL showLength;

@property (copy, nonatomic) IBInspectable NSString *placeholder;
@property (copy, nonatomic) NSAttributedString *attributedPlaceholder;

@property (nonatomic) IBInspectable double fadeTime;
@property (retain, nonatomic) UIColor *placeholderTextColor UI_APPEARANCE_SELECTOR;

@end
