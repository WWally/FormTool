//
//  WLFormSectionItem.h
//  WLFormTool
//
//  Created by Self.impr on 2018/8/15.
//  Copyright © 2018 bestlei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/**
 WLFormSectionItem 主要对表单section条目提供动态配置属性
 */
@interface WLFormSectionItem : NSObject

/**
 表单section包含的条目集合
 */
@property (nonatomic, strong, nonnull) NSArray *items;

/**
 表单section头部高度
 */
@property (nonatomic, assign) CGFloat headerHeight;

/**
 表单section尾部高度
 */
@property (nonatomic, assign) CGFloat footerHeight;

/**
 表单section头部视图
 */
@property (nonatomic, strong, nullable) UIView *headerView;

/**
 表单section尾部视图
 */
@property (nonatomic, strong, nullable) UIView *footerView;

@end

/**
 WLSectionItem 快捷构建表单section条目
 
 @param items 表单section包含的条目集合
 */
FOUNDATION_EXPORT WLFormSectionItem *WLSectionItem(NSArray * _Nonnull items);

