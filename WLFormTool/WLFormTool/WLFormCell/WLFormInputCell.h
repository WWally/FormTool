//
//  WLFormInputCell.h
//  WLFormDemo
//
//  Created by Self.impr on 2018/8/15.
//  Copyright © 2018 bestlei. All rights reserved.
//

#import "WLFormBaseCell.h"

@class WLFormItem;

/**
 输入内容block

 @param text 当前输入内容
 */
typedef void(^WLInputCompletion)(NSString *text);

/**
 WLFormInputCell 表单输入条目，标题居左，详情居右，支持单行与多行输入
 */
@interface WLFormInputCell : WLFormBaseCell

/**
 条目配置参数
 */
@property (nonatomic, strong) WLFormItem *item;

@property (nonatomic, copy) WLInputCompletion inputCompletion;

/**
 获取条目高度
 */
+ (CGFloat)heightWithItem:(WLFormItem *)item;


/**
 获取条目宽度
 */
+ (CGFloat)titleLabelWithItem:(WLFormItem *)item;

@end


/**
 WLFormInputCell 对于UITableView的分类，实现WLFormInputCell初始化
 */
@interface UITableView (WLFormInputCell)

- (WLFormInputCell *)inputCellWithId:(NSString *)cellId;

@end
