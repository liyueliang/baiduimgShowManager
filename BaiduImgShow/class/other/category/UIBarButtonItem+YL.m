//
//  UIBarButtonItem+YL.m
//  WeiBo
//
//  Created by jlt on 15/5/23.
//  Copyright (c) 2015年 lyl. All rights reserved.
//

#import "UIBarButtonItem+YL.h"
#import "UIImage+YL.h"
@implementation UIBarButtonItem (YL)
+(UIBarButtonItem *)itemWithIcon:(NSString *)icon highIcon:(NSString *)highIcon target:(id)target  action:(SEL)action{
    UIButton *buttonItem =[UIButton buttonWithType:UIButtonTypeCustom];
    [buttonItem setBackgroundImage:[UIImage imageWithName:icon] forState:UIControlStateNormal];
    [buttonItem setBackgroundImage:[UIImage imageWithName:highIcon] forState:UIControlStateHighlighted];
    buttonItem.bounds = CGRectMake(0, 0, buttonItem.currentBackgroundImage.size.width, buttonItem.currentBackgroundImage.size.height);
    [buttonItem addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc]initWithCustomView:buttonItem];
}
@end
