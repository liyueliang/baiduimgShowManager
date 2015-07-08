//
//  YLSDWebImgCacheTool.m
//  BaiduImgShow
//
//  Created by jlt on 15/7/3.
//  Copyright (c) 2015年 junhe. All rights reserved.
//

#import "YLSDWebImgCacheTool.h"
#import "ASIDownloadCache.h"
#import "SDImageCache.h"
#define  sdimgCacheDir @"sdImgResource"
@implementation YLSDWebImgCacheTool
 
+(float)cacheSize{
    NSInteger allSize = [[SDImageCache sharedImageCache] getSize];
    float totalSize = allSize/1024.0 / 1024.0;
    YLLog(@"tmp size is %.2f",totalSize);
       ;
    return totalSize;
}
+(void)clearCache{
    [[SDImageCache sharedImageCache] clearDisk];
}
@end
