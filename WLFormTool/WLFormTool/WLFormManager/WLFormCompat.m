//
//  WLFormCompat.m
//  WLFormTool
//
//  Created by Self.impr on 2018/8/15.
//  Copyright © 2018 bestlei. All rights reserved.
//

#import "WLFormCompat.h"

// 表单标题字体大小
CGFloat const WL_TitleFont = 14.0f;

// 表单详情字体大小
CGFloat const WL_InfoFont = 14.0f;

// 表单条目边缘距离
CGFloat const WL_EdgeMargin = 12.0f;

// 表单条目上下距离
CGFloat const WL_TopBottomMargin = 0.0f;

// 表单条目右距离
CGFloat const WL_RightMargin = 30.0f;

// 表单标题宽度
CGFloat const WL_TitleWidth = 80.0f;

// 表单标题高度
CGFloat const WL_TitleHeight = 50.0f;

// 表单条目初始高度
CGFloat const WL_DefaultItemHeight = 50.0f;
CGFloat const WL_DefaultTextViewItemHeight = 200.0f;

// 表单标题显示类别
NSInteger const WL_TitleShowType = WLTitleShowTypeRedStarFront;

// 表单输入字数限制
NSUInteger const WL_GlobalMaxInputLength = 200;

// 表单选择图片附件数
NSUInteger const WL_GlobalMaxImages = 6;

// 表单TextView字数提示文字大小
CGFloat const WL_LengHintFont = 14;

// 表单图片条目图片加载失败占位图
NSString *const WL_PlaceholderImage = @"WLForm.bundle/WLPlaceholderIcon";

// 表单附件删除图标
NSString *const WL_DeleteIcon = @"WLForm.bundle/WLDeleteIcon";

// 表单附件添加图标
NSString *const WL_AddIcon = @"WLForm.bundle/WLImageAdd";

inline CGSize WLSizeOfString(NSString *str, CGFloat font, CGSize maxSize) {
    return [str boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font]} context:nil].size;
}
