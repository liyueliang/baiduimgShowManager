//
//  UIBarButtonItem+YL.h
//  WeiBo
//
//  Created by jlt on 15/5/23.
//  Copyright (c) 2015年 lyl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (YL)
+(UIBarButtonItem *)itemWithIcon:(NSString *)icon highIcon:(NSString *)highIcon target:(id)target action:(SEL)action;
@end
