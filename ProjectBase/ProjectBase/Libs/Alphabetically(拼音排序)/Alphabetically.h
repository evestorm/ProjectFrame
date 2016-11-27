//
//  Alphabetically.h
//  Daiyanxiu
//
//  Created by 向云飞 on 16/7/10.
//  Copyright © 2016年 MyMac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


static NSString *const compareArray = @"compareArray";
static NSString *const compareKeys = @"compareKeys";

@interface Alphabetically : NSObject

/**
 *  @param originalArray 未排序的数组
 *  @param key           按照指定的值进行排序
 *
 *  @return 返回排序之后和对应索引的字典
 */
+ (NSDictionary *)dictionaryOrderByCharacterWithOriginalArray:(NSArray *)originalArray key:(NSString *)key;


#pragma mark - 使用方式
//NSDictionary *dict = [Alphabetically dictionaryOrderByCharacterWithOriginalArray:@[@""] key:@""];
//NSArray *values = [dict objectForKey:compareArray];  //排序之后的数组
//NSArray *keys = [dict objectForKey:compareKeys]; //索引数组

@end
