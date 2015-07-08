//
//  YLCustomerNavController.m
//  BaiduImgShow
//
//  Created by jlt on 15/6/30.
//  Copyright (c) 2015年 junhe. All rights reserved.
//

#import "YLCustomerNavController.h"
#import "UIImage+YL.h"
@interface YLCustomerNavController ()

@end

@implementation YLCustomerNavController

/*
 第一次使用这个类的时候会调用(1个类只会调用一次)
 */
+(void)initialize{
    //1: 设置导航栏主题
    //取出appearance对象
    [self setupNavBarTheme];
    
    //2:设置导航栏按钮主题
    [self setupBarButtonItemTheme];
    
    
}
+(void)setupNavBarTheme{
    UINavigationBar *navBar =[UINavigationBar appearance];
    if (!IOS7) {
        
        //设置背景
        [navBar setBackgroundImage:[UIImage imageWithName:@"navigationbar_background"] forBarMetrics:UIBarMetricsDefault];
        [UIApplication sharedApplication].statusBarStyle =UIStatusBarStyleBlackOpaque;
    }
    //设置标题属性
    NSMutableDictionary *textAttrs =[NSMutableDictionary dictionary];
    textAttrs[UITextAttributeTextColor] =[UIColor blackColor];
    textAttrs[UITextAttributeTextShadowOffset] =[NSValue valueWithUIOffset:UIOffsetZero];
    textAttrs[UITextAttributeFont]=[UIFont boldSystemFontOfSize:19];
    [navBar setTitleTextAttributes:textAttrs];
}
+(void)setupBarButtonItemTheme{
    UIBarButtonItem *item =[UIBarButtonItem appearance];
    if (!IOS7) {
        [item setBackgroundImage:[UIImage imageWithName:@"navigationbar_button_background"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
        [item setBackgroundImage:[UIImage imageWithName:@"navigationbar_button_background_pushed"] forState:UIControlStateHighlighted barMetrics:UIBarMetricsDefault];
        [item setBackgroundImage:[UIImage imageWithName:@"navigationbar_button_background_disable"] forState:UIControlStateDisabled barMetrics:UIBarMetricsDefault];
        
    }
    //设置文字属性
    NSMutableDictionary *textAttrs =[NSMutableDictionary dictionary];
    textAttrs[UITextAttributeTextColor] =IOS7?[UIColor orangeColor]:[UIColor grayColor];
    textAttrs[UITextAttributeTextShadowOffset] =[NSValue valueWithUIOffset:UIOffsetZero];
    textAttrs[UITextAttributeFont]=[UIFont systemFontOfSize:IOS7?14:12];
    
    [item setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    [item setTitleTextAttributes:textAttrs forState:UIControlStateHighlighted];
}
-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if (self.viewControllers.count>0) {
        [viewController setHidesBottomBarWhenPushed:YES];
    }
    [super pushViewController:viewController animated:YES];
}



@end
