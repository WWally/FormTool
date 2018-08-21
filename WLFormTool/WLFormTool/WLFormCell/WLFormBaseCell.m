//
//  WLFormBaseCell.m
//  WLFormTool
//
//  Created by Self.impr on 2018/8/15.
//  Copyright © 2018 bestlei. All rights reserved.
//

#import "WLFormBaseCell.h"
#import "SelwynExpandableTextView.h"
#import "WLFormCompat.h"

@interface WLFormBaseCell()<UITextViewDelegate>
@end

@implementation WLFormBaseCell

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.font = [UIFont systemFontOfSize:WL_TitleFont];
        _titleLabel.adjustsFontSizeToFitWidth = YES;
        _titleLabel.textColor = UIColorFromRGB(0x666666);
        [self.contentView addSubview:_titleLabel];
    }
    return _titleLabel;
}

- (SelwynExpandableTextView *)expandableTextView {
    if (!_expandableTextView) {
        _expandableTextView = [[SelwynExpandableTextView alloc]init];
        _expandableTextView.delegate = self;
        _expandableTextView.textContainerInset = UIEdgeInsetsMake(0, 0, 0, 0);
        _expandableTextView.textContainer.lineFragmentPadding = 0;
        _expandableTextView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        _expandableTextView.textColor = UIColorFromRGB(0x888888);
        _expandableTextView.backgroundColor = [UIColor clearColor];
        _expandableTextView.font = [UIFont systemFontOfSize:WL_InfoFont];
        _expandableTextView.scrollEnabled = NO;
        _expandableTextView.autocorrectionType = UITextAutocorrectionTypeNo;
        _expandableTextView.layoutManager.allowsNonContiguousLayout = NO;
        _expandableTextView.showsVerticalScrollIndicator = NO;
        _expandableTextView.showsHorizontalScrollIndicator = NO;
        [self.contentView addSubview:_expandableTextView];
    }
    return _expandableTextView;
}

- (UITextField *)expandableTextField{
    if (!_expandableTextField) {
        _expandableTextField = [[UITextField alloc]init];
        _expandableTextField.font = [UIFont systemFontOfSize:WL_TitleFont];
        _expandableTextField.adjustsFontSizeToFitWidth = YES;
        _expandableTextField.textAlignment = NSTextAlignmentRight;
        _expandableTextField.textColor = UIColorFromRGB(0x888888);
        [self.contentView addSubview:_expandableTextField];
    }
    return _expandableTextField;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
