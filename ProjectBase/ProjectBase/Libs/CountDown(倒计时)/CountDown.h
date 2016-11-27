//
//  CountDown.h
//  ProjectBase
//
//  Created by 向云飞 on 2016/10/22.
//  Copyright © 2016年 向云飞. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CountDown : NSObject

/**
 NSDate 日期倒计时

 @param startDate          开始时间
 @param finishDate         结束时间
 @param completeBlock      回调
 */
- (void)countDownWithStartDate:(NSDate *)startDate finishDate:(NSDate *)finishDate completeBlock:(void(^)(NSInteger day,NSInteger hour,NSInteger minute,NSInteger second))completeBlock;



/**
 时间戳倒计时

 @param startTimeStamp      开始时间戳
 @param finishTimeStamp     结束时间戳
 @param completeBlock       完成的回调
 */
- (void)countDownWithStartTimeStamp:(long long)startTimeStamp finishTimeStamp:(long long)finishTimeStamp completeBlock:(void (^)(NSInteger, NSInteger, NSInteger, NSInteger))completeBlock;


/**
 按照指定频率回调

 @param countDownFrequency 倒计时频率
 @param PER_SECBlock       回调
 */
-(void)countDownFrequency:(CGFloat)countDownFrequency WithPER_SECBlock:(void (^)())PER_SECBlock;


/**
 销毁定时器
 */
-(void)destoryTimer;


- (NSDate *)dateWithLongLong:(long long)longlongValue;

@end
