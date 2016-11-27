//
//  UIColor+HelperKit.h
//  ProjectBase
//
//  Created by 向云飞 on 16/7/26.
//  Copyright © 2016年 向云飞. All rights reserved.
//

#import <UIKit/UIKit.h>

#pragma mark - 设置颜色
@interface UIColor (HelperKit)


/**
 *  rgbHex字符转换UIColor
 */
+ (UIColor *)colorWithRGBHex:(UInt32)hex;

/**
 *  Hex字符转换UIColor
 */
+ (UIColor *)colorWithHexString:(NSString *)stringToConvert;

/**
 *  Hex字符转换UIColor
 */
+ (UIColor *)transformRGBColor:(NSString *)colorValue;


@end


#pragma mark - 渐变颜色
@interface UIColor (Gradient)

/**
 *  渐变颜色
 *
 *  @param fromColor 开始颜色
 *  @param toColor   结束颜色
 *  @param height    渐变高度
 *
 *  @return 渐变颜色
 */
+ (UIColor *)gradientFromColor:(UIColor *)fromColor toColor:(UIColor *)toColor withHeight:(int)height;

@end



#pragma mark - 修改颜色
@interface UIColor (Modify)

/**
 *  反转颜色
 */
- (UIColor *)invertedColor;

/**
 *  颜色半透明
 */
- (UIColor *)colorForTranslucency;

@end

























