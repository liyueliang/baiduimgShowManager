//
//  AppDelegate.h
//  BaiduImgShow
//
//  Created by jlt on 15/6/18.
//  Copyright (c) 2015年 junhe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIDownloadCache.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property(nonatomic,strong) ASIDownloadCache *myCache;

@end

