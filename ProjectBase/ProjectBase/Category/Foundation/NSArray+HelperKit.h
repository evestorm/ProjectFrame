//
//  NSArray+HelperKit.h
//  ProjectBase
//
//  Created by 向云飞 on 16/7/30.
//  Copyright © 2016年 向云飞. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (HelperKit)

/**
 *  数组中包含某个字符
 *
 *  @param string 传入的字符
 *
 *  @return 包含返回YES 否则返回NO
 */
- (BOOL)arrayContainsString:(NSString *)string;

/**
 *  将数组按索引从大到小排序
 *
 *  @return 返回索引由大到小的新数组
 */
- (NSArray *)reverseArray;

@end
