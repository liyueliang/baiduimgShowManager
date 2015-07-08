//
//  YLSettingItem.m
//  BaiduImgShow
//
//  Created by lyl on 15/6/29.
//  Copyright (c) 2015年 junhe. All rights reserved.
//

#import "YLSettingItem.h"

@implementation YLSettingItem
+(instancetype)itemWithTitle:(NSString *)title{
    return [self itemWithIcon:nil title:title];
}
+(instancetype)itemWithIcon:(NSString *)icon title:(NSString *)title{
    YLSettingItem *item =[[self alloc]init];
    item.icon=icon;
    item.title=title;
    return item; 
}
-(void)dealloc{
    YLLog(@"%@ dealloc",NSStringFromClass([self class]));
}
@end
