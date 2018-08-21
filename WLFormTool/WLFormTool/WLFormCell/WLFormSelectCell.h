//
//  WLFormSelectCell.h
//  WLFormDemo
//
//  Created by Self.impr on 2018/8/15.
//  Copyright © 2018 bestlei. All rights reserved.
//

#import "WLFormBaseCell.h"

@class WLFormItem;

/**
 WLFormSelectCell 表单选择条目
 */
@interface WLFormSelectCell : WLFormBaseCell

@property (nonatomic, strong) WLFormItem *item;

+ (CGFloat)heightWithItem:(WLFormItem *)item;

@end


@interface UITableView (WLFormSelectCell)

- (WLFormSelectCell *)selectCellWithId:(NSString *)cellId;

@end
