//
//  WLFormBaseController.h
//  WLFormDemo
//
//  Created by Self.impr on 2018/8/15.
//  Copyright © 2018 bestlei. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^WLFormSubmitCompletion)(void);

/**
 WLFormBaseController 表单基类，所有表单必须继承于BaseController，实现了表单动态配置
 */
@interface WLFormBaseController : UIViewController

/**
 表单tableView
 */
@property (nonatomic, strong) UITableView *formTableView;

/**
 表单数据源，数据源格式应为 @[WLFormSection..]，否则断言会直接崩溃
 */
@property (nonatomic, strong) NSMutableArray *mutableItems;

/**
 提交操作事件block，包含提交操作表单页面提交按钮点击事件实现回调
 */
@property (nonatomic, copy) WLFormSubmitCompletion submitCompletion;

/**
 表单页面初始化方法

 @param style 表单tableView样式
 */
- (instancetype)initWithStyle:(UITableViewStyle)style;

@end
