//
//  WLFormSelectCell.m
//  WLFormDemo
//
//  Created by Self.impr on 2018/8/15.
//  Copyright © 2018 bestlei. All rights reserved.
//

#import "WLFormSelectCell.h"
#import "WLFormItem.h"
#import "SelwynExpandableTextView.h"
#import "WLFormCompat.h"
#import "NSString+WLForm.h"

@implementation WLFormSelectCell

- (void)setItem:(WLFormItem *)item {
    _item = item;
    self.titleLabel.attributedText = item.attributedTitle;
    self.expandableTextField.text = [item.info addUnit:item.unit];
    self.expandableTextField.placeholder = item.placeholder;
    self.expandableTextField.enabled = item.editable;
    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.titleLabel.frame = CGRectMake(WL_EdgeMargin, (self.item.defaultHeight - WL_TitleHeight)/2, WL_TitleWidth, WL_TitleHeight);
    self.expandableTextField.userInteractionEnabled = NO;
    
    CGFloat newHeight = [WLFormSelectCell heightWithItem:self.item];
    self.expandableTextField.frame = CGRectMake(WL_TitleWidth + 2*WL_EdgeMargin, WL_EdgeMargin, WL_SCRREN_WIDTH - (WL_TitleWidth + 2*WL_EdgeMargin + 30),  newHeight - 2*WL_EdgeMargin);
}

+ (CGFloat)heightWithItem:(WLFormItem *)item {
    CGFloat infoHeight = WLSizeOfString(item.info, WL_InfoFont, CGSizeMake(WL_SCRREN_WIDTH - WL_TitleWidth - 2*WL_EdgeMargin - 30, MAXFLOAT)).height;
    return MAX(item.defaultHeight, infoHeight + 2*WL_EdgeMargin);
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end

@implementation UITableView (WLFormSelectCell)

- (WLFormSelectCell *)selectCellWithId:(NSString *)cellId
{
    WLFormSelectCell *cell = [self dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[WLFormSelectCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.expandableTableView = self;
    }
    return cell;
}

@end
