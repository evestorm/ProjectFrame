//
//  CountDown.m
//  ProjectBase
//
//  Created by 向云飞 on 2016/10/22.
//  Copyright © 2016年 向云飞. All rights reserved.
//

#import "CountDown.h"

@interface CountDown ()

@property(nonatomic,retain) dispatch_source_t timer;
@property(nonatomic,retain) NSDateFormatter *dateFormatter;

@end

@implementation CountDown


- (instancetype)init {
    self = [super init];
    if (self) {
        self.dateFormatter = [[NSDateFormatter alloc] init];
        [self.dateFormatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
        NSTimeZone *localTimeZone = [NSTimeZone localTimeZone];
        [self.dateFormatter setTimeZone:localTimeZone];
    }
    return self;
}


/**
 NSDate 日期倒计时
 
 @param startDate          开始时间
 @param finishDate         结束时间
 @param completeBlock      回调
 */
- (void)countDownWithStartDate:(NSDate *)startDate finishDate:(NSDate *)finishDate completeBlock:(void(^)(NSInteger day,NSInteger hour,NSInteger minute,NSInteger second))completeBlock {
    
    if (_timer == nil) {
        NSTimeInterval timeInterval = [finishDate timeIntervalSinceDate:startDate];
        __block int timeOut = timeInterval;
        if (timeOut!=0) {
            dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
            _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
            dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0), 1.0f *NSEC_PER_SEC, 0); //按照频率执行
            dispatch_source_set_event_handler(_timer, ^{
                if(timeOut<=0){ //倒计时结束，关闭
                    dispatch_source_cancel(_timer);
                    _timer = nil;
                    dispatch_async(dispatch_get_main_queue(), ^{
                        completeBlock(0,0,0,0);
                    });
                }else{
                    int days = (int)(timeOut/(3600*24));
                    int hours = (int)((timeOut-days*24*3600)/3600);
                    int minute = (int)(timeOut-days*24*3600-hours*3600)/60;
                    int second = timeOut-days*24*3600-hours*3600-minute*60;
                    dispatch_async(dispatch_get_main_queue(), ^{
                        completeBlock(days,hours,minute,second);
                    });
                    timeOut--;
                }
            });
            dispatch_resume(_timer);
        }
    }

}



/**
 时间戳倒计时
 
 @param startTimeStamp      开始时间戳
 @param finishTimeStamp     结束时间戳
 @param countDownFrequency  倒计时频率  默认1秒
 @param completeBlock       完成的回调
 */
- (void)countDownWithStartTimeStamp:(long long)startTimeStamp finishTimeStamp:(long long)finishTimeStamp completeBlock:(void (^)(NSInteger, NSInteger, NSInteger, NSInteger))completeBlock {
    
    if (_timer==nil) {
        NSDate *finishDate = [self dateWithLongLong:finishTimeStamp];
        NSDate *startDate  = [self dateWithLongLong:startTimeStamp];
        NSTimeInterval timeInterval =[finishDate timeIntervalSinceDate:startDate];
        __block int timeout = timeInterval; //倒计时时间
        if (timeout!=0) {
            dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
            _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
            dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0f * NSEC_PER_SEC, 0); //按照频率执行
            dispatch_source_set_event_handler(_timer, ^{
                if(timeout<=0){ //倒计时结束，关闭
                    dispatch_source_cancel(_timer);
                    _timer = nil;
                    dispatch_async(dispatch_get_main_queue(), ^{
                        completeBlock(0,0,0,0);
                    });
                }else{
                    int days = (int)(timeout/(3600*24));
                    int hours = (int)((timeout-days*24*3600)/3600);
                    int minute = (int)(timeout-days*24*3600-hours*3600)/60;
                    int second = timeout-days*24*3600-hours*3600-minute*60;
                    dispatch_async(dispatch_get_main_queue(), ^{
                        completeBlock(days,hours,minute,second);
                    });
                    timeout--;
                }
            });
            dispatch_resume(_timer);
        }
    }
}


/**
 按照指定频率回调
 
 @param countDownFrequency 倒计时频率
 @param PER_SECBlock       回调
 */
-(void)countDownFrequency:(CGFloat)countDownFrequency WithPER_SECBlock:(void (^)())PER_SECBlock {
    if (countDownFrequency <= 0) {
        NSAssert(NO, @"倒计时频率必须大于0");
    }
    
    if (_timer==nil) {
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
        dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),countDownFrequency * NSEC_PER_SEC, 0); //按照频率执行
        dispatch_source_set_event_handler(_timer, ^{
            dispatch_async(dispatch_get_main_queue(), ^{
                PER_SECBlock();
            });
        });
        dispatch_resume(_timer);
    }
}


/**
 销毁定时器
 */
-(void)destoryTimer {
    if (_timer) {
        dispatch_source_cancel(_timer);
        _timer = nil;
    }
}


- (NSDate *)dateWithLongLong:(long long)longlongValue {
    long long value = longlongValue / 1000;
    NSNumber *time = [NSNumber numberWithLongLong:value];
    NSTimeInterval timeInterval = [time longValue];
    NSDate *date = [[NSDate alloc] initWithTimeIntervalSince1970:timeInterval];
    return date;
}

@end
