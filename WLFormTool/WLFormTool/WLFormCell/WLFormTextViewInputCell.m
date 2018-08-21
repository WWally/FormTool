//
//  WLFormTextViewInputCell.m
//  WLFormDemo
//
//  Created by Self.impr on 2018/8/15.
//  Copyright © 2018 bestlei. All rights reserved.
//

#import "WLFormTextViewInputCell.h"
#import "WLFormItem.h"
#import "SelwynExpandableTextView.h"
#import "WLFormCompat.h"
#import "UITextView+TextLimit.h"
#import "NSString+WLForm.h"

@interface WLFormTextViewInputCell()<UITextViewDelegate>
@end

@implementation WLFormTextViewInputCell

- (void)setItem:(WLFormItem *)item {
    _item = item;
    self.titleLabel.attributedText = item.attributedTitle;
    self.expandableTextView.text = [item.info addUnit:item.unit];
    self.expandableTextView.attributedPlaceholder = item.attributedPlaceholder;
    self.expandableTextView.editable = item.editable;
    self.expandableTextView.keyboardType = item.keyboardType;
    self.expandableTextView.currentLength = item.info.length;
    self.expandableTextView.showLength = item.showLength;
    self.expandableTextView.maxLength = item.maxInputLength;
    self.accessoryType = UITableViewCellAccessoryNone;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.titleLabel.frame = CGRectMake(WL_EdgeMargin, WL_EdgeMargin, WL_SCRREN_WIDTH - 2*WL_EdgeMargin, WL_TitleHeight);
    
    //重置 expandableTextView 内边距
    self.expandableTextView.textContainerInset = UIEdgeInsetsMake(WL_EdgeMargin, WL_EdgeMargin, WL_EdgeMargin, WL_EdgeMargin);
    self.expandableTextView.backgroundColor = WL_TEXTVIEW_BACKGROUNDCOLOR;
    
    CGFloat newHeight = [WLFormTextViewInputCell heightWithItem:self.item];
    self.expandableTextView.frame = CGRectMake(WL_EdgeMargin, CGRectGetMaxY(self.titleLabel.frame) + WL_EdgeMargin, WL_SCRREN_WIDTH - 2*WL_EdgeMargin, newHeight - 3*WL_EdgeMargin - WL_TitleHeight);
}

- (void)textViewDidBeginEditing:(UITextView *)textView {
    self.expandableTextView.text = self.item.info;
    self.expandableTextView.currentLength = self.expandableTextView.text.length;
}

- (void)textViewDidChange:(UITextView *)textView {
    if (self.item.maxInputLength > 0) {
        [self.expandableTextView textLimitWithMaxLength:self.item.maxInputLength];
    }
    self.expandableTextView.currentLength = self.expandableTextView.text.length;
    if (self.textViewInputCompletion) {
        self.textViewInputCompletion(self.expandableTextView.text);
    }
    [UIView performWithoutAnimation:^{
        [self.expandableTableView beginUpdates];
        [self.expandableTableView endUpdates];
    }];
}

- (void)textViewDidEndEditing:(UITextView *)textView {
    
    self.expandableTextView.currentLength = self.expandableTextView.text.length;
    self.expandableTextView.text = [self.item.info addUnit:self.item.unit];
}

+ (CGFloat)heightWithItem:(WLFormItem *)item {
    CGFloat infoHeight = WLSizeOfString(item.info, WL_InfoFont, CGSizeMake(WL_SCRREN_WIDTH - 4*WL_EdgeMargin, MAXFLOAT)).height;
    return MAX(item.defaultHeight, infoHeight + WL_TitleHeight + 5*WL_EdgeMargin);
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end

@implementation UITableView (WLFormTextViewInputCell)

- (WLFormTextViewInputCell *)textViewInputCellWithId:(NSString *)cellId
{
    WLFormTextViewInputCell *cell = [self dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[WLFormTextViewInputCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.expandableTableView = self;
    }
    return cell;
}

@end
