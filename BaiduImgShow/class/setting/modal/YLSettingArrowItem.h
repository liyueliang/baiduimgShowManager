//
//  YLSettingArrowItem.h
//  BaiduImgShow
//
//  Created by lyl on 15/6/29.
//  Copyright (c) 2015年 junhe. All rights reserved.
//

#import "YLSettingItem.h"

@interface YLSettingArrowItem : YLSettingItem
////点击cell需要跳转的控制器
@property(nonatomic,assign) Class destVcClass;
+(instancetype)itemWithTitle:(NSString *)title destVcClass:(Class )destVcClass;
+(instancetype)itemWithIcon:(NSString *)icon title:(NSString *)title destVcClass:(Class)destVcClass;
@end
