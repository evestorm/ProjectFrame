//
//  UIImage+HelperKit.h
//  ProjectBase
//
//  Created by 向云飞 on 16/7/27.
//  Copyright © 2016年 向云飞. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (HelperKit)

/**
 *  纯色图片
 *
 *  @param color 颜色
 *
 *  @return 返回纯色图片
 */
+ (UIImage *)imageWithColor:(UIColor *)color;

/**
 *  纯色图片
 *
 *  @param color 颜色
 *  @param frame 尺寸
 *
 *  @return 返回指定大小的纯色图片
 */
+ (UIImage *)imageWithColor:(UIColor *)color frame:(CGRect)frame;


/**
 *  图片缩放
 *
 *  @param targetSize 缩放尺寸
 *
 *  @return 返回缩放后的图片
 */
- (UIImage *)scaleToSize:(CGSize)targetSize;

/**
 *  图片缩放
 *
 *  @param targetSize  缩放尺寸
 *  @param highQuality 图片缩放质量是否高
 *
 *  @return 返回缩放后的图片
 */
- (UIImage *)scaleToSize:(CGSize)targetSize highQuality:(BOOL)highQuality;


/**
 *  图片缩放
 *
 *  @param mmaxSize 缩放到的最大尺寸
 *
 *  @return 返回缩放后的图片
 */
- (UIImage *)scaleToMaxSize:(CGSize)maxSize;



@end
