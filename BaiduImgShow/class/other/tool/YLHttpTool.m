//
//  YLHttpTool.m
//  BaiduImgShow
//
//  Created by jlt on 15/6/30.
//  Copyright (c) 2015年 junhe. All rights reserved.
//

#import "YLHttpTool.h"
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
#import "AppDelegate.h"
#import "MBProgressHUD+MJ.h"  
@implementation YLHttpTool
+(void)getWithURL:(NSString *)url params:(NSDictionary *)params success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    //创建请求管理对象

    ASIHTTPRequest *request =[ASIHTTPRequest requestWithURL:[NSURL URLWithString:url]];
    AppDelegate *appDelegate =[[UIApplication sharedApplication]delegate];
    [request setDownloadCache:appDelegate.myCache] ;
    __weak ASIHTTPRequest *tempRequest =request;
    //设置缓存数据存储策略 这里采取的是如果无更新或没有联网就读取缓存数据
      
    [request setCacheStoragePolicy:ASICachePermanentlyCacheStoragePolicy];
    [request setCompletionBlock:^{
        int code = tempRequest.responseStatusCode;
        if (code==200) {
            success([tempRequest responseString]);
         }
    }];
    [request setFailedBlock:^{
        
        [MBProgressHUD showError:[NSString stringWithFormat:@"%@",[tempRequest.error localizedDescription]]];
        failure([tempRequest error]);
        
    }];
    //启动请求
    [request startAsynchronous]; 
}
+(void)postWithURL:(NSString *)url params:(NSDictionary *)params success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    //创建请求管理对象
    
    ASIFormDataRequest *formRequest =[ASIFormDataRequest requestWithURL:[NSURL URLWithString:url]];
    AppDelegate *appDelegate =[[UIApplication sharedApplication]delegate];
    for (id key in params) {
        [formRequest setPostValue:[params objectForKey:key] forKey:key];
    }
    [formRequest setDownloadCache:appDelegate.myCache] ;
    __weak ASIFormDataRequest *tempRequest =formRequest;
    //设置缓存数据存储策略 这里采取的是如果无更新或没有联网就读取缓存数据
    [formRequest setCacheStoragePolicy:ASICachePermanentlyCacheStoragePolicy];
    [formRequest setCompletionBlock:^{
        int code = tempRequest.responseStatusCode;
        if (code==200) {
            success([tempRequest responseString]);
        }
    }];
    [formRequest setFailedBlock:^{
        
        [MBProgressHUD showError:[NSString stringWithFormat:@"%@",[tempRequest.error localizedDescription]]];
        failure([tempRequest error]);
        
    }];
    //启动请求
    [formRequest startAsynchronous];
}

+(void)postWithURL:(NSString *)url params:(NSDictionary *)params formData:(NSArray *)formData success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    //创建请求管理对象
    
    ASIFormDataRequest *formRequest =[ASIFormDataRequest requestWithURL:[NSURL URLWithString:url]];
    AppDelegate *appDelegate =[[UIApplication sharedApplication]delegate];
    for (id key in params) {
        [formRequest setPostValue:[params objectForKey:key] forKey:key];
    }
    if (formData) { //发送媒体文件
        for (YLMedioModal *medio in formData) {
            [formRequest setFile:medio.fileName forKey:medio.name];
        }
    }
   
    [formRequest setDownloadCache:appDelegate.myCache] ;
    __weak ASIFormDataRequest *tempRequest =formRequest;
    //设置缓存数据存储策略 这里采取的是如果无更新或没有联网就读取缓存数据
    [formRequest setCacheStoragePolicy:ASICachePermanentlyCacheStoragePolicy];
    [formRequest setCompletionBlock:^{
        int code = tempRequest.responseStatusCode;
        if (code==200) {
            success([tempRequest responseString]);
        }
    }];
    [formRequest setFailedBlock:^{
        
        [MBProgressHUD showError:[NSString stringWithFormat:@"%@",[tempRequest.error localizedDescription]]];
        failure([tempRequest error]);
        
    }];
    //启动请求
    [formRequest startAsynchronous];
}
@end
