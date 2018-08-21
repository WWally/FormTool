//
//  WLFormHandler.h
//  WLFormDemo
//
//  Created by Self.impr on 2018/8/15.
//  Copyright © 2018 bestlei. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 WLFormHandler 数据校验文件，包含相机权限、相册权限以及表单空数据校验
 */
@interface WLFormHandler : NSObject

/**
 必选(必填)数据空数据校验，可根据需求定制

 @param datas 表单数据源
 @param success 必选(必填)数据全部校验成功
 @param failure 必选(必填)数据某一项校验失败
 */
+ (void)wl_checkFormNullDataWithWithDatas:(NSArray *)datas success:(void(^)(void))success failure:(void(^)(NSString *error))failure;



@end
