//
//  NSDate+HelperKit.h
//  ProjectBase
//
//  Created by 向云飞 on 16/8/2.
//  Copyright © 2016年 向云飞. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (HelperKit)


#pragma mark - 返回“刚刚、X分钟前、X小时前、X个月前、X年前”
+ (NSString *)compareCurrentTime:(NSDate *)date;
+ (NSString *)compareCurrentTimeString:(NSString *)timsStamp;


#pragma mark - 日期是否相等
- (BOOL)isSameDay:(NSDate *)anotherDate;
- (BOOL)isSameDay:(NSDate *)date1 withDate:(NSDate *)date2;
- (BOOL)isSameDayString:(NSString *)date1TimeStamp withDateString:(NSString *)date2TimeStamp;

#pragma mark - 获取年年、月、日、小时、分钟、秒
- (NSInteger)year;
- (NSInteger)month;
- (NSInteger)day;
- (NSInteger)hour;
- (NSInteger)minute;
- (NSInteger)second;
+ (NSInteger)year:(NSDate *)date;
+ (NSInteger)month:(NSDate *)date;
+ (NSInteger)day:(NSDate *)date;
+ (NSInteger)hour:(NSDate *)date;
+ (NSInteger)minute:(NSDate *)date;
+ (NSInteger)second:(NSDate *)date;
+ (NSInteger)getYear:(NSString *)timeStamp;
+ (NSInteger)getMonth:(NSString *)timeStamp;
+ (NSInteger)getDay:(NSString *)timeStamp;
+ (NSInteger)getHour:(NSString *)timeStamp;
+ (NSInteger)getMinute:(NSString *)timeStamp;
+ (NSInteger)getSecond:(NSString *)timeStamp;


@end
