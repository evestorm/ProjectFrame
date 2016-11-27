//
//  UIColor+HelperKit.m
//  ProjectBase
//
//  Created by 向云飞 on 16/7/26.
//  Copyright © 2016年 向云飞. All rights reserved.
//

#import "UIColor+HelperKit.h"

#pragma mark - 设置颜色
@implementation UIColor (HelperKit)

/**
 *  rgbHex字符转换UIColor
 */
+ (UIColor *)colorWithRGBHex:(UInt32)hex {
    int r = (hex >> 16) & 0xFF;
    int g = (hex >> 8) & 0xFF;
    int b = (hex) & 0xFF;
    return [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:1.0f];
}

/**
 *  Hex字符转换UIColor
 */
+ (UIColor *)colorWithHexString:(NSString *)stringToConvert {
    NSString *cString = [[stringToConvert stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) {
        return [UIColor clearColor];
    }
    
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"])
        cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    if ([cString length] != 6)
        return [UIColor clearColor];
    
    NSScanner *scanner = [NSScanner scannerWithString:cString];
    unsigned hexNum;
    if (![scanner scanHexInt:&hexNum]) return nil;
    return [UIColor colorWithRGBHex:hexNum];
}


/**
 *  Hex字符转换UIColor
 */
+ (UIColor *)transformRGBColor:(NSString *)colorValue {
    UIColor * color = nil;
    
    NSMutableString * value = [NSMutableString stringWithFormat:@"%@",colorValue];
    
    //转换成16进制
    [value replaceCharactersInRange:[value rangeOfString:@"#"] withString:@"0x" ];
    
    //将16进制转换成整形
    long longColor = strtoul([value cStringUsingEncoding:NSUTF8StringEncoding], 0, 16);
    
    //通过位与方法获取三色值
    int R = (longColor & 0xFF0000)>>16;
    int G = (longColor & 0x00FF00)>>8;
    int B = (longColor & 0x0000FF);
    
    color = [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:1.0];
    
    return color;
}

@end


#pragma mark - 渐变颜色
@implementation UIColor (Gradient)
/**
 *  渐变颜色
 *
 *  @param fromColor 开始颜色
 *  @param toColor   结束颜色
 *  @param height    渐变高度
 *
 *  @return 渐变颜色
 */
+ (UIColor *)gradientFromColor:(UIColor *)fromColor toColor:(UIColor *)toColor withHeight:(int)height {
    CGSize size = CGSizeMake(1, height);
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGColorSpaceRef colorspace = CGColorSpaceCreateDeviceRGB();
    NSArray *colors = [NSArray arrayWithObjects:(id)fromColor.CGColor,(id)toColor.CGColor, nil];
    CGGradientRef gradient = CGGradientCreateWithColors(colorspace, (__bridge CFArrayRef)colors, NULL);
    CGContextDrawLinearGradient(context, gradient, CGPointMake(0, 0), CGPointMake(0, size.height), 0);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    CGGradientRelease(gradient);
    CGColorSpaceRelease(colorspace);
    UIGraphicsEndImageContext();
    
    return [UIColor colorWithPatternImage:image];
    
}
@end


#pragma mark - 修改颜色
@implementation UIColor (Modify)

/**
 *  反转颜色
 */

- (UIColor *)invertedColor {
    NSArray *components = [self componentArray];
    return [UIColor colorWithRed:1-[components[0] doubleValue] green:1-[components[1] doubleValue] blue:1-[components[2] doubleValue] alpha:[components[3] doubleValue]];
}

/**
 *  颜色半透明
 */

- (UIColor *)colorForTranslucency {
    CGFloat hue = 0, saturaion = 0, brightness = 0, alpha = 0;
    [self getHue:&hue saturation:&saturaion brightness:&brightness alpha:&alpha];
    return [UIColor colorWithHue:hue saturation:saturaion brightness:brightness alpha:alpha];
}

- (NSArray *)componentArray {
    CGFloat red,green,blue,alpha;
    const CGFloat *components = CGColorGetComponents([self CGColor]);
    if (CGColorGetNumberOfComponents([self CGColor]) == 2) {
        red = components[0];
        green = components[0];
        blue = components[0];
        alpha = components[1];
    } else {
        red = components[0];
        green = components[1];
        blue = components[2];
        alpha = components[3];
    }
    return @[@(red),@(green),@(blue),@(alpha)];
}

@end