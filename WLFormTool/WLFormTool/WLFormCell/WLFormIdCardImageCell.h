//
//  WLFormIdCardImageCell.h
//  WLFormTool
//
//  Created by Self.impr on 2018/8/15.
//  Copyright © 2018 bestlei. All rights reserved.
//

#import "WLFormBaseCell.h"

@class WLFormItem;

typedef void(^WLJustDeleteImageCompletion)(void);

typedef void(^WLReverseDeleteImageCompletion)(void);
/**
 图片选择或删除block
 
 @param images 当前已存在图片数组
 */
typedef void(^WLImageCompletion)(NSArray *images);

/**
 WLFormImageCell 表单图片选择条目
  */
@interface WLFormIdCardImageCell : WLFormBaseCell

@property (nonatomic, strong) WLFormItem * item;
@property (nonatomic, copy) WLImageCompletion imageCompletion;

/**
 正面图片删除操作block
 */
@property (nonatomic, copy) WLJustDeleteImageCompletion justdeleteImageCompletion;

/**
 反面图片删除操作block
 */
@property (nonatomic, copy) WLReverseDeleteImageCompletion ReversedeleteImageCompletion;

+ (CGFloat)heightWithItem:(WLFormItem *)item;

@end

//@interface UITableView (WLFormImageCell)
//
//- (WLFormIdCardImageCell *)imageCellWithId:(NSString *)cellId;
//
//@end
