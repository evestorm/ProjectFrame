//
//  Alphabetically.m
//  Daiyanxiu
//
//  Created by 向云飞 on 16/7/10.
//  Copyright © 2016年 MyMac. All rights reserved.
//

#import "Alphabetically.h"

@implementation Alphabetically

+ (NSDictionary *)dictionaryOrderByCharacterWithOriginalArray:(NSArray *)originalArray key:(NSString *)key {
    if (!originalArray.count) {
        return nil;
    }
    
    //初始化
    UILocalizedIndexedCollation *indexedCollation = [UILocalizedIndexedCollation currentCollation];
    NSMutableArray *newSectionArray = [[NSMutableArray alloc] init];
    
    //构建每个section数组
    for (int i = 0; i < indexedCollation.sectionTitles.count; i ++) {
        NSMutableArray *simpleModel = [[NSMutableArray alloc] init];
        [newSectionArray addObject:simpleModel];
    }
    
    NSMutableArray *keys = [[NSMutableArray alloc] init];
    
    //将需要排序的对象放入到对应的分区数组中、对应的索引值插入相应的数组中
    NSInteger lastIndex = -1;
    for (int i = 0; i < originalArray.count; i ++) {
        id model = originalArray[i];
        NSInteger index = [indexedCollation sectionForObject:[model valueForKey:key] collationStringSelector:@selector(uppercaseString)];
        [[newSectionArray objectAtIndex:index] addObject:model];
        [keys addObject:[indexedCollation.sectionTitles objectAtIndex:index]];
        lastIndex = index;
    }
    
    //移除空的分区数组
    for (int i = 0 ; i < newSectionArray.count; i ++) {
        NSMutableArray *obj = newSectionArray[i];
        if (!obj.count) {
            [newSectionArray removeObject:obj];
        }
    }
    
    //索引值去重
    NSSet *set = [NSSet setWithArray:keys];
    NSArray *comparedKeys = [set allObjects];
    
    //索引值排序
    NSArray *sortedKeys = [comparedKeys sortedArrayUsingSelector:@selector(compare:)];
    
    //在包含#索引的值 调整分区数组顺序
    if ([sortedKeys.firstObject isEqualToString:@"#"]) {
        [newSectionArray insertObject:newSectionArray.lastObject atIndex:0];
        [newSectionArray removeObjectAtIndex:newSectionArray.count - 1];
    }
    
    return @{compareKeys : sortedKeys,compareArray : newSectionArray};
    
}

@end
