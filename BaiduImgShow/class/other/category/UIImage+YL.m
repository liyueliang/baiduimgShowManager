//
//  UIImage+adaptation.m
//  WeiBo
//
//  Created by lyl on 15/5/18.
//  Copyright (c) 2015年 lyl. All rights reserved.
//

#import "UIImage+YL.h"

@implementation UIImage (YL)
+(UIImage *)imageWithName:(NSString *)name{
    
    if (IOS7) {
       NSString *newName =[name stringByAppendingString:@"_os7"];
        UIImage *image =[UIImage imageNamed:newName];
        if (image==nil) { //说明没有找到os7对应的图片
            image =[UIImage imageNamed:name];
        }
        return image;
    }
    //非ios7
    return [UIImage imageNamed:name];
    
}
+(UIImage *)resizedImageWithName:(NSString *)name{ 
    return [self resizedImageWithName:name left:0.5 top:0.5];
}
+(UIImage *)resizedImageWithName:(NSString *)name left:(CGFloat)left top:(CGFloat)top{
    UIImage *currentImage =[self imageWithName:name];
    return [currentImage stretchableImageWithLeftCapWidth:currentImage.size.width*left topCapHeight:currentImage.size.height*top];
}
@end
