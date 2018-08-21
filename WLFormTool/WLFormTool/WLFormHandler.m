//
//  WLFormHandler.m
//  WLFormDemo
//
//  Created by Self.impr on 2018/8/15.
//  Copyright © 2018 bestlei. All rights reserved.
//

#import "WLFormHandler.h"
#import <Photos/PHPhotoLibrary.h>
#import <AVFoundation/AVCaptureDevice.h>
#import <UIKit/UIKit.h>
#import "WLFormItem.h"
#import "WLFormSectionItem.h"

@implementation WLFormHandler

+ (void)wl_checkFormNullDataWithWithDatas:(NSArray *)datas success:(void(^)(void))success failure:(void(^)(NSString *error))failure {
    for (int sec = 0; sec < datas.count; sec++) {
        WLFormSectionItem *sectionItem = datas[sec];
        for (int row = 0; row < sectionItem.items.count; row++) {
            WLFormItem *rowItem = sectionItem.items[row];
            if (rowItem.required) {
                if (rowItem.itemType == WLFormItemTypeInput || rowItem.itemType == WLFormItemTypeTextViewInput) {
                    if (!rowItem.info || [rowItem.info isEqualToString:@""]) {
                        failure([NSString stringWithFormat:@"请输入%@", rowItem.title]);
                        return;
                    }
                }
                else if (rowItem.itemType == WLFormItemTypeSelect) {
                    if (!rowItem.info || [rowItem.info isEqualToString:@""]) {
                        failure([NSString stringWithFormat:@"请选择%@", rowItem.title]);
                        return;
                    }
                }
            }
        }
    }
    success();
}



@end
