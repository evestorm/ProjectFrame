//
//  UIFont+HelperKit.h
//  ProjectBase
//
//  Created by 向云飞 on 16/7/27.
//  Copyright © 2016年 向云飞. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIFont (HelperKit)

/**
 *  设置字体
 *
 *  @param size 字体大小
 *
 *  @return 返回字体
 */
+ (UIFont *)fontWithSize:(float)size;


/**
 *  设置加粗字体
 *
 *  @param size 字体大小
 *
 *  @return 返回加粗字体
 */
+ (UIFont *)fontBoldWithSize:(float)size;

@end
