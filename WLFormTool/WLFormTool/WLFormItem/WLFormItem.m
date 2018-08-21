//
//  WLFormItem.m
//  WLFormTool
//
//  Created by Self.impr on 2018/7/9.
//  Copyright © 2018 bestlei. All rights reserved.
//

#import "WLFormItem.h"
#import "WLFormCompat.h"

static NSString *const WLUnitYuan = @"元";
static NSString *const WLUnitYear = @"年";
static NSString *const WLUnitMillion = @"万元";

@interface WLFormItem()

+ (instancetype)wl_itemWithTitle:(NSString *)title info:(NSString *)info itemType:(WLFormItemType)itemType editable:(BOOL)editable required:(BOOL)required keyboardType:(UIKeyboardType)keyboardType;

+ (instancetype)wl_itemWithTitle:(NSString *)title info:(NSString *)info itemType:(WLFormItemType)itemType;

@end

inline WLFormItem *WLFormItem_Add(NSString * _Nonnull title, NSString * _Nullable info,NSString * _Nullable placeholder, WLFormItemType itemType, BOOL editable, BOOL required, UIKeyboardType keyboardType) {
    return [WLFormItem wl_itemWithTitle:title info:info itemType:itemType editable:editable required:required keyboardType:keyboardType];
}

inline WLFormItem *WLFormItem_Info(NSString * _Nonnull title, NSString * _Nullable info, WLFormItemType itemType) {
    return [WLFormItem wl_itemWithTitle:title info:info itemType:itemType];
}

@implementation WLFormItem

+ (instancetype)wl_itemWithTitle:(NSString *)title info:(NSString *)info itemType:(WLFormItemType)itemType editable:(BOOL)editable required:(BOOL)required keyboardType:(UIKeyboardType)keyboardType {
    return [[self alloc]initWithTitle:title info:info itemType:itemType editable:editable required:required keyboardType:keyboardType images:nil showPlaceholder:YES];
}

+ (instancetype)wl_itemWithTitle:(NSString *)title info:(NSString *)info itemType:(WLFormItemType)itemType {
    return [[self alloc]initWithTitle:title info:info itemType:itemType editable:NO required:NO keyboardType:UIKeyboardTypeDefault images:nil showPlaceholder:NO];
}

- (instancetype)initWithTitle:(NSString *)title info:(NSString *)info itemType:(WLFormItemType)itemType editable:(BOOL)editable required:(BOOL)required keyboardType:(UIKeyboardType)keyboardType images:(NSArray *)images showPlaceholder:(BOOL)showPlaceholder{
    self = [super init];
    if (self) {
        self.itemUnitType = WLFormItemUnitTypeNone;
        self.maxInputLength = WL_GlobalMaxInputLength;
        self.maxImageCount = WL_GlobalMaxImages;
        self.title = title;
        self.info = info;
        self.itemType = itemType;
        self.editable = editable;
        self.required = required;
        self.keyboardType = keyboardType;
        self.images = images;
        self.showPlaceholder = showPlaceholder;
        [self wl_setDefaultHeight:itemType];
        [self wl_setPlaceholderWithShow:showPlaceholder itemType:itemType];
        [self wl_setAttributedTitleWithRequired:required title:title itemType:itemType];
    }
    return self;
}

#pragma mark -- 根据表单条目类型设置条目缺省高度
- (void)wl_setDefaultHeight:(WLFormItemType)itemType {
    self.defaultHeight = itemType == WLFormItemTypeTextViewInput ? WL_DefaultTextViewItemHeight:WL_DefaultItemHeight;
}

#pragma mark -- 设置是否显示输入框占位字符
- (void)wl_setPlaceholderWithShow:(BOOL)show itemType:(WLFormItemType)itemType {
    if (!show) {
        self.placeholder = @"";
        return;
    }
    switch (itemType) {
        case WLFormItemTypeInput:
        case WLFormItemTypeTextViewInput:
        {
            self.placeholder = @"请输入";
        }
            break;
        case WLFormItemTypeSelect:
        {
            self.placeholder = @"请选择";
        }
            break;
        case WLFormItemTypeOneDate:
        {
            self.placeholder = @"请选择时间";
        }
            break;
        case WLFormItemTypeAddress:
        {
            self.placeholder = @"请选择时间";
        }
            break;
        case WLFormItemTypeOther:
        {
            self.placeholder = @"请选择";
        }
            break;
        default:
            self.placeholder = @"";
            break;
    }
}

#pragma mark -- 设置标题显示
- (void)wl_setAttributedTitleWithRequired:(BOOL)required title:(NSString *)title itemType:(WLFormItemType)itemType{
    if (required) {
        if (WL_TitleShowType == WLTitleShowTypeDefault) {
            switch (self.itemType) {
                case WLFormItemTypeInput:
                case WLFormItemTypeTextViewInput:
                {
                    title = [NSString stringWithFormat:@"%@(必填)", title];
                }
                    break;
                case WLFormItemTypeSelect:
                {
                    title = [NSString stringWithFormat:@"%@(必选)", title];
                }
                    break;
                default:
                    break;
            }
        }
        else if (WL_TitleShowType == WLTitleShowTypeRedStarFront) {
            title = [NSString stringWithFormat:@"*%@", title];
        }
        else if (WL_TitleShowType == WLTitleShowTypeRedStarBack) {
            title = [NSString stringWithFormat:@"%@*", title];
        }
    }
    
    NSMutableAttributedString *attributedTitle = [[NSMutableAttributedString alloc]initWithString:title attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:WL_TitleFont], NSForegroundColorAttributeName:WL_TITLECOLOR}];
    
    if (required) {
        if (WL_TitleShowType == WLTitleShowTypeRedStarFront) {
            [attributedTitle addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, 1)];
        }
        else if (WL_TitleShowType == WLTitleShowTypeRedStarBack) {
            [attributedTitle addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(title.length - 1, 1)];
        }
    }
    _attributedTitle = attributedTitle;
}

#pragma mark -- 重写get方法
- (NSArray *)selectImages {
    NSMutableArray *tempImages = [NSMutableArray array];
    for (id temp in self.images) {
        if ([temp isKindOfClass:[UIImage class]]) {
            [tempImages addObject:temp];
        }
    }
    return tempImages;
}

#pragma mark -- 重写属性set方法，防止单独改变属性无响应效果
/**
 设置表单条目附带单位
 */
- (void)setItemUnitType:(WLFormItemUnitType)itemUnitType {
    NSString *tempUnit = self.unit ?: @"";
    switch (itemUnitType) {
        case WLFormItemUnitTypeNone:
        {
            tempUnit = @"";
        }
            break;
        case WLFormItemUnitTypeYuan:
        {
            tempUnit = WLUnitYuan;
        }
            break;
        case WLFormItemUnitTypeYear:
        {
            tempUnit = WLUnitYear;
        }
            break;
        case WLFormItemUnitTypeMillion:
        {
            tempUnit = WLUnitMillion;
        }
        default:
            break;
    }
    _unit = tempUnit;
}

/**
 根据单位设置单元格单位类别，防止单位与单元格式不一致
 */
- (void)setUnit:(NSString *)unit {
    _unit = unit;
    if ([unit isEqualToString:@""]) {
        _itemUnitType = WLFormItemUnitTypeNone;
    }
    else if (unit == WLUnitYuan) {
        _itemUnitType = WLFormItemUnitTypeYuan;
    }
    else if (unit == WLUnitYear) {
        _itemUnitType = WLFormItemUnitTypeYear;
    }
    else if (unit == WLUnitMillion) {
        _itemUnitType = WLFormItemUnitTypeMillion;
    }
    else {
        _itemUnitType = WLFormItemUnitTypeCustom;
    }
}

- (void)setImages:(NSArray *)images {
    _images = images;
    [self selectImages];
}

- (void)setTitle:(NSString *)title {
    _title = title;
    [self wl_setAttributedTitleWithRequired:self.required title:title itemType:self.itemType];
}

- (void)setRequired:(BOOL)required {
    _required = required;
    [self wl_setAttributedTitleWithRequired:required title:self.title itemType:self.itemType];
}

- (void)setItemType:(WLFormItemType)itemType {
    _itemType = itemType;
    [self wl_setDefaultHeight:itemType];
    [self wl_setAttributedTitleWithRequired:self.required title:self.title itemType:itemType];
    [self wl_setPlaceholderWithShow:self.showPlaceholder itemType:itemType];
}

- (void)setShowPlaceholder:(BOOL)showPlaceholder {
    _showPlaceholder = showPlaceholder;
    [self wl_setPlaceholderWithShow:showPlaceholder itemType:self.itemType];
}

- (void)setPlaceholder:(NSString *)placeholder {
    _placeholder = placeholder;
    NSAttributedString *attributedPlaceholder = [[NSAttributedString alloc]initWithString:placeholder ?: @"" attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:WL_InfoFont],NSForegroundColorAttributeName:WL_PLACEHOLDERCOLOR}];
    _attributedPlaceholder = attributedPlaceholder;
}

- (void)setAttributedPlaceholder:(NSAttributedString *)attributedPlaceholder {
    _attributedPlaceholder = attributedPlaceholder ?: [[NSAttributedString alloc]initWithString:@""];
}
@end
