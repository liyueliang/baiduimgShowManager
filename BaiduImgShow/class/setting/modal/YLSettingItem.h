//
//  YLSettingItem.h
//  BaiduImgShow
//
//  Created by lyl on 15/6/29.
//  Copyright (c) 2015年 junhe. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^YLSettingItemOption)();
@interface YLSettingItem : NSObject
//图标
@property(nonatomic,copy) NSString *icon;
//标题
@property(nonatomic,copy) NSString *title;
//子标题
@property(nonatomic,copy) NSString *subTitle;
//点击cell需要做什么事情
@property(nonatomic,copy) YLSettingItemOption option;
//存储当前对象对应的key
@property(nonatomic,copy) NSString *key;

+(instancetype)itemWithTitle:(NSString *)title;
+(instancetype)itemWithIcon:(NSString *)icon title:(NSString *)title;

@end
