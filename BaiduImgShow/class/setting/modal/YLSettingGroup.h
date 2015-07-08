//
//  YLSettingGroup.h
//  BaiduImgShow
//
//  Created by lyl on 15/6/29.
//  Copyright (c) 2015年 junhe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YLSettingGroup : NSObject
//头部标题
@property(nonatomic,copy) NSString *header;
//尾部标题
@property(nonatomic,copy) NSString *footer;
//存放这组所有的settingitem
@property(nonatomic,copy) NSArray *items;
@end
