//
//  YLSettingArrowItem.m
//  BaiduImgShow
//
//  Created by lyl on 15/6/29.
//  Copyright (c) 2015年 junhe. All rights reserved.
//

#import "YLSettingArrowItem.h"

@implementation YLSettingArrowItem
+(instancetype)itemWithTitle:(NSString *)title destVcClass:(Class)destVcClass{
    
    return [self itemWithIcon:nil title:title destVcClass:destVcClass];
}
+(instancetype)itemWithIcon:(NSString *)icon title:(NSString *)title destVcClass:(Class)destVcClass{
    YLSettingArrowItem *item =[[self alloc]init];
   item.icon =icon;
    item.title =title;
    item.destVcClass =destVcClass;
    return item;
}
@end
