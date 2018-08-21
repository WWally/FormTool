//
//  WLFormInputCell.m
//  WLFormDemo
//
//  Created by Self.impr on 2018/8/15.
//  Copyright © 2018 bestlei. All rights reserved.
//

#import "WLFormInputCell.h"
#import "WLFormItem.h"
#import "WLFormCompat.h"
#import "SelwynExpandableTextView.h"
#import "UITextView+TextLimit.h"
#import "UITextField+TextLimit.h"
#import "NSString+WLForm.h"

@interface WLFormInputCell()<UITextViewDelegate>

@end

@implementation WLFormInputCell

- (void)setItem:(WLFormItem *)item {
    _item = item;
    self.titleLabel.attributedText = item.attributedTitle;
    self.expandableTextField.text = [item.info addUnit:item.unit];
    self.expandableTextField.placeholder = item.placeholder;
    self.expandableTextField.enabled = item.editable;
    self.expandableTextField.keyboardType = item.keyboardType;
    
//    self.expandableTextView.text = [item.info addUnit:item.unit];
//    self.expandableTextView.attributedPlaceholder = item.attributedPlaceholder;
//    self.expandableTextView.editable = item.editable;
//    self.expandableTextView.keyboardType = item.keyboardType;
    self.accessoryType = UITableViewCellAccessoryNone;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    


    CGFloat newWidth = [WLFormInputCell titleLabelWithItem:self.item];
    self.titleLabel.frame = CGRectMake(WL_EdgeMargin, WL_TopBottomMargin, newWidth + 10, WL_DefaultItemHeight);
    
    CGFloat newHeight = [WLFormInputCell heightWithItem:self.item];
    self.expandableTextField.frame = CGRectMake(WL_EdgeMargin + 15 + newWidth, WL_TopBottomMargin, WL_SCRREN_WIDTH - (WL_EdgeMargin + 15 + newWidth) - WL_RightMargin, WL_DefaultItemHeight);
}

- (void)textViewDidBeginEditing:(UITextView *)textView {
    self.expandableTextField.text = self.item.info;
}

- (void)textViewDidChange:(UITextView *)textView {
    if (self.item.maxInputLength > 0) {
        // 限制输入字数
        [self.expandableTextField textLimitWithMaxLength:self.item.maxInputLength];
    }
    if (self.inputCompletion) {
        self.inputCompletion(self.expandableTextField.text);
    }
    // 防止输入时表单因刷新动画抖动
    [UIView performWithoutAnimation:^{
        [self.expandableTableView beginUpdates];
        [self.expandableTableView endUpdates];
    }];
}

- (void)textViewDidEndEditing:(UITextView *)textView {
    self.expandableTextView.text = [self.item.info addUnit:self.item.unit];
}

+ (CGFloat)heightWithItem:(WLFormItem *)item {
    CGFloat infoHeight = WLSizeOfString(item.info, WL_InfoFont, CGSizeMake(WL_SCRREN_WIDTH - (WL_TitleWidth + 3*WL_EdgeMargin), MAXFLOAT)).height;
    return MAX(item.defaultHeight, infoHeight + 2*WL_EdgeMargin);
}

+ (CGFloat)titleLabelWithItem:(WLFormItem *)item{
    CGFloat infoWidth = WLSizeOfString(item.title, WL_InfoFont, CGSizeMake(WL_SCRREN_WIDTH, MAXFLOAT)).width;
    return infoWidth;
    
}
- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end


@implementation UITableView (WLFormInputCell)

- (WLFormInputCell *)inputCellWithId:(NSString *)cellId
{
    WLFormInputCell *cell = [self dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[WLFormInputCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.expandableTableView = self;
    }
    return cell;
}

@end
