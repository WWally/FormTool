//
//  WLFormBaseCell.h
//  WLFormTool
//
//  Created by Self.impr on 2018/8/15.
//  Copyright © 2018 bestlei. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SelwynExpandableTextView;

/**
 WLFormBaseCell 表单条目基类，所有表单条目都继承于BaseCell
 */
@interface WLFormBaseCell : UITableViewCell

@property (nonatomic, strong) SelwynExpandableTextView *expandableTextView;

/**
 表单标题
 */
@property (nonatomic, strong) UILabel *titleLabel;

/**
 表单条目所在的tableView
 */
@property (nonatomic, weak) UITableView *expandableTableView;

/**
 textfield
 */
@property (nonatomic, strong) UITextField * expandableTextField;

@end
