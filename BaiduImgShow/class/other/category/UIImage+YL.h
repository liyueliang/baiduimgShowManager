//
//  UIImage+adaptation.h
//  WeiBo
//  扩展图像功能
//  添加ios6,7适配功能
//  Created by lyl on 15/5/18.
//  Copyright (c) 2015年 lyl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (YL)
/*
  加载图片
 */
+(UIImage *)imageWithName:(NSString *)name;
+(UIImage *)resizedImageWithName:(NSString *)name;
+(UIImage *)resizedImageWithName:(NSString *)name left:(CGFloat)left top:(CGFloat)top;
@end
