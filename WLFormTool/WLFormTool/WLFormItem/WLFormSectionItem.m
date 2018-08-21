//
//  WLFormSectionItem.m
//  WLFormTool
//
//  Created by Self.impr on 2018/8/15.
//  Copyright © 2018 bestlei. All rights reserved.
//

#import "WLFormSectionItem.h"

@interface WLFormSectionItem()

+ (instancetype)wl_sectionItem:(NSArray *)items;

@end

inline WLFormSectionItem * WLSectionItem(NSArray * _Nonnull items) {
    return [WLFormSectionItem wl_sectionItem:items];
}

@implementation WLFormSectionItem

+ (instancetype)wl_sectionItem:(NSArray *)items {
    return [[self alloc]initWithItems:items];
}

- (instancetype)initWithItems:(NSArray *)items {
    self = [super init];
    if (self) {
        self.items = items;
    }
    return self;
}

@end
