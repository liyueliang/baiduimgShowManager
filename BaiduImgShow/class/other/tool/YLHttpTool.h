//
//  YLHttpTool.h
//  BaiduImgShow
//
//  Created by jlt on 15/6/30.
//  Copyright (c) 2015年 junhe. All rights reserved.
// 

#import <Foundation/Foundation.h>

@interface YLHttpTool : NSObject
/**
 *  发送一个get请求
 *
 *  @param url     请求路径
 *  @param params  请求参数
 *  @param success 请求成功处理函数
 *  @param failure 请求失败处理函数
 */
+(void)getWithURL:(NSString *)url params:(NSDictionary *)params success:(void (^)(id json))success failure:(void(^)(NSError *error))failure;
/**
 *  发送一个post请求
 *
 *  @param url     请求路径
 *  @param params  请求参数
 *  @param success 请求成功处理函数
 *  @param failure 请求失败处理函数
 */
+(void)postWithURL:(NSString *)url params:(NSDictionary *)params success:(void (^)(id json))success failure:(void(^)(NSError *error))failure;
/**
 *   发送一个post请求 并上传文件
 *  @param url      请求路径
 *  @param params   请求参数
 *  @param formData  文件集合
 *  @param success  请求成功处理函数
 *  @param failure  请求失败处理函数
 */
+(void)postWithURL:(NSString *)url params:(NSDictionary *)params formData:(NSArray *)formData success:(void (^)(id json))success failure:(void(^)(NSError *error))failure;
@end





@interface YLMedioModal : NSObject
/**
 *  文件名
 */
@property(nonatomic,copy) NSString *name;
/**
 *  文件路径
 */
@property(nonatomic,copy) NSString *fileName;
/**
 *  文件媒体格式
 */
@property(nonatomic,copy) NSString *mimeType;
/**
 *  文件二进制数据
 */
@property(nonatomic,strong) NSData *data;
@end

