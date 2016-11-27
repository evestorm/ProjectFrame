//
//  NSDate+HelperKit.m
//  ProjectBase
//
//  Created by 向云飞 on 16/8/2.
//  Copyright © 2016年 向云飞. All rights reserved.
//

#import "NSDate+HelperKit.h"

#define CurrentCalendar [NSCalendar currentCalendar]
#define DateComponents (NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekOfYear | NSCalendarUnitWeekOfMonth | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond | NSCalendarUnitWeekday | NSCalendarUnitWeekdayOrdinal)

@implementation NSDate (HelperKit)

#pragma mark - 返回“刚刚、X分钟前、X小时前、X个月前、X年前”
+ (NSString *)compareCurrentTime:(NSDate *)date {
    
    if (!date) {
        return @"";
    }
    
    NSDate *currentDate = [NSDate date];
    
    NSTimeInterval timeInterval = -[date timeIntervalSinceDate:currentDate];
    
    NSInteger year = [NSDate year:date];
    NSInteger month = [NSDate month:date];
    NSInteger day = [NSDate day:date];
    NSInteger hour = [NSDate hour:date];
    NSInteger minute = [NSDate minute:date];
        
    NSString *result;
    long temp = 0;
    if (timeInterval < 60) {
        result = @"刚刚";
    }else if (timeInterval < 60 * 60) {
        temp = timeInterval / 60;
        result = [NSString stringWithFormat:@"%ld分钟前",temp];
    }else if (timeInterval < 60 * 60 * 24) {
        temp =  timeInterval / 3600;
        result = [NSString stringWithFormat:@"%ld小时前",temp];
    }else if (timeInterval < 60 * 60 * 24 * 2) {
        if (minute < 10) {
            result = [NSString stringWithFormat:@"昨天:%ld:0%ld",hour,minute];
        }else {
            result = [NSString stringWithFormat:@"昨天:%ld:%ld",hour,minute];
        }
    }else {
        result = [NSString stringWithFormat:@"%ld-%ld-%ld %02ld-%02ld",year,month,day,hour,minute];
    }
    return result;
}

+ (NSString *)compareCurrentTimeString:(NSString *)timsStamp {
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[timsStamp integerValue]];
    return [NSDate compareCurrentTime:date];
}

#pragma mark - 日期是否相等
- (BOOL)isSameDay:(NSDate *)anotherDate {
    
    NSDate *currentDate = [NSDate date];
    return ([anotherDate year] == [currentDate year] && [anotherDate month] == [currentDate month] && [anotherDate day] == [currentDate day]);
}

- (BOOL)isSameDay:(NSDate *)date1 withDate:(NSDate *)date2 {
    return ([date1 year] == [date2 year] && [date1 month] == [date2 month] && [date1 day] == [date2 day]);
}

- (BOOL)isSameDayString:(NSString *)date1TimeStamp withDateString:(NSString *)date2TimeStamp {
    NSDate *date1 = [NSDate dateWithTimeIntervalSince1970:[date1TimeStamp integerValue]];
    NSDate *date2 = [NSDate dateWithTimeIntervalSince1970:[date2TimeStamp integerValue]];
    return ([date1 year] == [date2 year] && [date1 month] == [date2 month] && [date1 day] == [date2 day]);
}


#pragma mark - 获取年年、月、日、小时、分钟、秒
- (NSInteger)year {
    NSDateComponents *components = [CurrentCalendar components:DateComponents fromDate:self];
    return components.year;
}

- (NSInteger)month {
    NSDateComponents *components = [CurrentCalendar components:DateComponents fromDate:self];
    return components.month;
}

- (NSInteger)day {
    NSDateComponents *componetns = [CurrentCalendar components:DateComponents fromDate:self];
    return componetns.day;
}

- (NSInteger)hour {
    NSDateComponents *components = [CurrentCalendar components:DateComponents fromDate:self];
    return components.hour;
}

- (NSInteger)minute {
    NSDateComponents *components = [CurrentCalendar components:DateComponents fromDate:self];
    return components.minute;
}

- (NSInteger)second {
    NSDateComponents *componetns = [CurrentCalendar components:DateComponents fromDate:self];
    return componetns.second;
}

+ (NSInteger)year:(NSDate *)date {
    NSDateComponents *yearComponents = [CurrentCalendar components:(NSCalendarUnitYear) fromDate:date];
    return yearComponents.year;
}

+ (NSInteger)month:(NSDate *)date {
    NSDateComponents *monthComponents = [CurrentCalendar components:NSCalendarUnitMonth fromDate:date];
    return monthComponents.month;
}

+ (NSInteger)day:(NSDate *)date {
    NSDateComponents *dayComponents = [CurrentCalendar components:NSCalendarUnitDay fromDate:date];
    return dayComponents.day;
}

+ (NSInteger)hour:(NSDate *)date {
    NSDateComponents *hourComponents = [CurrentCalendar components:NSCalendarUnitHour fromDate:date];
    return hourComponents.hour;
}

+ (NSInteger)minute:(NSDate *)date {
    NSDateComponents *minuteComponents = [CurrentCalendar components:NSCalendarUnitMinute fromDate:date];
    return minuteComponents.minute;
}

+ (NSInteger)second:(NSDate *)date {
    NSDateComponents *secondComponents = [CurrentCalendar components:NSCalendarUnitSecond fromDate:date];
    return secondComponents.second;
}

+ (NSInteger)getYear:(NSString *)timeStamp {
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[timeStamp integerValue]];
    return [NSDate year:date];
}

+ (NSInteger)getMonth:(NSString *)timeStamp {
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[timeStamp integerValue]];
    return [NSDate month:date];
}

+ (NSInteger)getDay:(NSString *)timeStamp {
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[timeStamp integerValue]];
    return [NSDate day:date];
}

+ (NSInteger)getHour:(NSString *)timeStamp {
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[timeStamp integerValue]];
    return [NSDate hour:date];
}

+ (NSInteger)getMinute:(NSString *)timeStamp {
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[timeStamp integerValue]];
    return [NSDate minute:date];
}

+ (NSInteger)getSecond:(NSString *)timeStamp {
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[timeStamp integerValue]];
    return [NSDate second:date];
}

@end
