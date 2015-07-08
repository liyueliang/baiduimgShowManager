//
//  NSDate+YL.h
//  WeiBo
//
//  Created by jlt on 15/5/28.
//  Copyright (c) 2015年 lyl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (YL)
-(BOOL)isToday;
-(BOOL)isYesterday;
-(BOOL)isThisYear;
-(NSDateComponents *)deltaWithNow;
@end
