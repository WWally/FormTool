//
//  WLFormTextViewInputCell.h
//  WLFormDemo
//
//  Created by Self.impr on 2018/8/15.
//  Copyright © 2018 bestlei. All rights reserved.
//

#import "WLFormBaseCell.h"

@class WLFormItem;

typedef void(^WLTextViewInputCompletion)(NSString *text);

/**
 WLFormTextViewInputCell 表单输入条目，标题居上，详情居下，支持单行与多行输入
 */
@interface WLFormTextViewInputCell : WLFormBaseCell

@property (nonatomic, strong) WLFormItem *item;
@property (nonatomic, copy) WLTextViewInputCompletion textViewInputCompletion;

+ (CGFloat)heightWithItem:(WLFormItem *)item;

@end


@interface UITableView (WLFormTextViewInputCell)

- (WLFormTextViewInputCell *)textViewInputCellWithId:(NSString *)cellId;

@end
