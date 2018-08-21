//
//  WLFormCompat.h
//  WLFormTool
//
//  Created by Self.impr on 2018/8/15.
//  Copyright © 2018 bestlei. All rights reserved.
//

/**
 WLFormCompat 主要配置表单涉及的相关常量参数，可根据需求修改配置
 */
#import <UIKit/UIKit.h>

/**
 必选条目标题呈现形式类别
 */
typedef NS_ENUM(NSInteger, WLTitleShowType) {
    /**
     默认呈现形式，如: 标题(必填)
     */
    WLTitleShowTypeDefault,
    /**
     标题前部加红色*，如: *标题
     */
    WLTitleShowTypeRedStarFront,
    /**
     标题后部加红色*，如: 标题*
     */
    WLTitleShowTypeRedStarBack,
    /**
     仅显示标题
     */
    WLTitleShowTypeOnlyTitle,
};

/**
 表单标题字体大小，缺省为14
 */
extern CGFloat const WL_TitleFont;

/**
 表单详情字体大小，缺省为14
 */
extern CGFloat const WL_InfoFont;

/**
 表单条目边缘距离，缺省为10.0f
 */
extern CGFloat const WL_EdgeMargin;

// 表单条目上下距离
extern CGFloat const WL_TopBottomMargin;

// 表单条目上下距离
extern CGFloat const WL_RightMargin;

/**
 表单标题宽度，缺省为100.0f
 */
extern CGFloat const WL_TitleWidth;

/**
 表单标题高度，缺省为24.0f
 */
extern CGFloat const WL_TitleHeight;

/**
 表单条目初始高度，缺省为44.0f，WLFormItemTypeTextViewInput 类型缺省高度为200，为确保显示正常，设置值>= 44
 */
extern CGFloat const WL_DefaultItemHeight;
extern CGFloat const WL_DefaultTextViewItemHeight;

/**
 表单标题显示类别，缺省为 WLTitleShowTypeRedStarFront
 */
extern NSInteger const WL_TitleShowType;

/**
 表单输入字数限制，缺省为200
 0 表示无限制
 */
extern NSUInteger const WL_GlobalMaxInputLength;

/**
 表单选择图片附件数，缺省为6
 */
extern NSUInteger const WL_GlobalMaxImages;

/**
 表单图片条目图片加载失败占位图
 */
extern NSString *const WL_PlaceholderImage;

/**
 表单附件删除图标
 */
extern NSString *const WL_DeleteIcon;

/**
 表单附件添加图标
 */
extern NSString *const WL_AddIcon;

/**
 表单TextView字数提示文字大小
 */
extern CGFloat const WL_LengHintFont;

/**
 获取文字内容的Size大小

 @param str 文字内容
 @param font 字体大小
 @param maxSize 最大显示Size
 */
FOUNDATION_EXPORT CGSize WLSizeOfString(NSString *str, CGFloat font, CGSize maxSize);

/**
 表单条目输入框占位符字体颜色
 */
#define WL_PLACEHOLDERCOLOR [UIColor colorWithRed:187/255.0 green:187/255.0 blue:187/255.0 alpha:1/1.0]

/**
 WLFormItemTypeTextViewInput 类别 TextView 背景颜色
 */
#define WL_TEXTVIEW_BACKGROUNDCOLOR [UIColor colorWithRed:250/255.0 green:250/255.0 blue:250/255.0 alpha:1/1.0]
/**
 表单条目标题颜色
 */
#define WL_TITLECOLOR [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1/1.0]

/**
 获取屏幕宽度
 */
#define WL_SCRREN_WIDTH [UIScreen mainScreen].bounds.size.width


//RGB color macro 0X00000
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
