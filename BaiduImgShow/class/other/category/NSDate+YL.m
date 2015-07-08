//
//  NSDate+YL.m
//  WeiBo
//
//  Created by jlt on 15/5/28.
//  Copyright (c) 2015年 lyl. All rights reserved.
//

#import "NSDate+YL.h"

@implementation NSDate (YL)
-(BOOL)isToday{
    //获取当前日历对应的年月日
    NSCalendar *calendar =[NSCalendar currentCalendar];
    int unit =NSCalendarUnitYear|NSCalendarUnitDay|NSCalendarUnitMonth;
    NSDateComponents *nowCmps =[calendar components:unit fromDate:[NSDate date]]
    ;
    //获取self的年月日
    NSDateComponents *selfCmps =[calendar components:unit fromDate:self];
    return
    (selfCmps.year==nowCmps.year)&&
    (selfCmps.month==nowCmps.month)&&
    (selfCmps.day==nowCmps.day);
}
-(BOOL)isYesterday{
    NSDate *now =[NSDate date];
    NSDateFormatter *fmt =[[NSDateFormatter alloc]init];
    fmt.dateFormat=@"yyyy-MM-dd";
    NSString *nowStr = [fmt stringFromDate:now];
    NSDate *nowData =[fmt dateFromString:nowStr];
    //self
    NSString *seldStr =[fmt stringFromDate:self];
    NSDate *selfDate =[fmt dateFromString:seldStr];
    
    NSCalendar *calendar =[NSCalendar currentCalendar];
    NSDateComponents *cmps = [calendar components:NSCalendarUnitDay fromDate:selfDate toDate:nowData options:0];
    
    return cmps.day==1;
}
-(BOOL)isThisYear{
    //获取当前日历对应的年月日
    NSCalendar *calendar =[NSCalendar currentCalendar];
    int unit =NSCalendarUnitYear;
    NSDateComponents *nowCmps =[calendar components:unit fromDate:[NSDate date]]
    ;
    //获取self的年月日
    NSDateComponents *selfCmps =[calendar components:unit fromDate:self];
    
    return selfCmps.year==nowCmps.year;
}
-(NSDateComponents *)deltaWithNow{
    //获取当前日历对应的年月日
    NSCalendar *calendar =[NSCalendar currentCalendar];
    int unit =NSCalendarUnitHour|NSCalendarUnitMinute|NSCalendarUnitSecond;
    return [calendar components:unit fromDate:self toDate:[NSDate date] options:0];
}
@end
