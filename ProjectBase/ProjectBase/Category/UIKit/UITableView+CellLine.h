//
//  UITableView+CellLine.h
//  ProjectBase
//
//  Created by 向云飞 on 16/7/29.
//  Copyright © 2016年 向云飞. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableView (CellLine)

/**
 *  添加UITableViewCell底部的分割线
 *
 *  @param cell      UITableViewCell
 *  @param indexPath NSIndexPath
 *  @param leftSpace 分割线左边距
 *  @param color     分割线颜色
 */
- (void)addLineforPlainCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath withLeftSpace:(CGFloat)leftSpace withLineColor:(NSString *)color;



- (void)addLineforPlainCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath withLeftSpaceAndSectionLine:(CGFloat)leftSpace withLineColor:(NSString *)color;


- (void)addLineforPlainCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath withLeftSpace:(CGFloat)leftSpace withLineColor:(NSString *)color hasSectionLine:(BOOL)hasSectionLine;



@end
