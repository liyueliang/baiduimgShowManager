//
//  YLImageModel.h
//  BaiduImgShow
//
//  Created by jlt on 15/6/23.
//  Copyright (c) 2015年 junhe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YLImageModel : NSObject
@property(nonatomic,strong) NSString *gid;
@property(nonatomic,strong) NSString *desc;
@property(nonatomic,strong) NSString  *fromPageTitle;
@property(nonatomic,strong) NSString *column;
@property(nonatomic,strong) NSString *parentTag;
@property(nonatomic,strong) NSString *date;
@property(nonatomic,strong) NSString *downloadUrl;
@property(nonatomic,strong) NSString *imageUrl;
@property(nonatomic,assign) int imageWidth;
@property(nonatomic,assign) int imageHeight;
@property(nonatomic,strong) NSString *thumbnailUrl;
@property(nonatomic,assign) int thumbnailWidth;
@property(nonatomic,assign) int thumbnailHeight;
@property(nonatomic,assign) int thumbLargeWidth;
@property(nonatomic,assign) int thumbLargeHeight;
@property(nonatomic,strong) NSString *thumbLargeUrl;
@property(nonatomic,assign) int thumbLargeTnWidth;
@property(nonatomic,assign) int thumbLargeTnHeight;
@property(nonatomic,strong) NSString *thumbLargeTnUrl;
@end
