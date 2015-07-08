//
//  YLSDWebImgCacheTool.h
//  BaiduImgShow
//
//  Created by jlt on 15/7/3.
//  Copyright (c) 2015年 junhe. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIDownloadCache.h"
@interface YLSDWebImgCacheTool : NSObject
 
/**
 *  硬盘缓存图片大小
 *
 *  @return <#return value description#>
 */
+(float)cacheSize;
/**
 *  清除硬盘缓存
 */
+(void)clearCache;
@end
