//
//  NSArray+HelperKit.m
//  ProjectBase
//
//  Created by 向云飞 on 16/7/30.
//  Copyright © 2016年 向云飞. All rights reserved.
//

#import "NSArray+HelperKit.h"

@implementation NSArray (HelperKit)

/**
 *  数组中包含某个字符
 *
 *  @param string 传入的字符
 *
 *  @return 包含返回YES 否则返回NO
 */
- (BOOL)arrayContainsString:(NSString *)string {
    for (NSString *element in self) {
        if ([element isKindOfClass:[NSString class]] && [element isEqualToString:string]) {
            return YES;
        }
    }
    return NO;
}

/**
 *  将数组按索引从大到小排序
 *
 *  @return 返回索引由大到小的新数组
 */
- (NSArray *)reverseArray {
    NSMutableArray *tempArray = [NSMutableArray arrayWithCapacity:self.count];
    NSEnumerator *enumerator = [self reverseObjectEnumerator];
    
    for (id element in enumerator) {
        [tempArray addObject:element];
    }
    return tempArray;
}

@end
