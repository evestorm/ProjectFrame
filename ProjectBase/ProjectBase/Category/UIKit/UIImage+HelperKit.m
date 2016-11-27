//
//  UIImage+HelperKit.m
//  ProjectBase
//
//  Created by 向云飞 on 16/7/27.
//  Copyright © 2016年 向云飞. All rights reserved.
//

#import "UIImage+HelperKit.h"

@implementation UIImage (HelperKit)

/**
 *  纯色图片
 *
 *  @param color 颜色
 *
 *  @return 返回纯色图片
 */
+ (UIImage *)imageWithColor:(UIColor *)color {
    return [UIImage imageWithColor:color frame:CGRectMake(0, 0, 1, 1)];
}


/**
 *  纯色图片
 *
 *  @param color 颜色
 *  @param frame 尺寸
 *
 *  @return 返回指定大小的纯色图片
 */
+ (UIImage *)imageWithColor:(UIColor *)color frame:(CGRect)frame {
    UIGraphicsBeginImageContext(frame.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, frame);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

/**
 *  图片缩放
 *
 *  @param targetSize 缩放尺寸
 *
 *  @return 返回缩放后的图片
 */
- (UIImage *)scaleToSize:(CGSize)targetSize {
    UIImage *sourceImage = self;
    UIImage *newImage = nil;
    CGSize imageSize = sourceImage.size;
    CGFloat scaleFactor = 0.0;
    if (CGSizeEqualToSize(imageSize, targetSize) == NO) {
        CGFloat widthFactor = targetSize.width / imageSize.width;
        CGFloat heightFactor = targetSize.height / imageSize.height;
        scaleFactor = widthFactor > heightFactor ? widthFactor : heightFactor;
    }
    
    scaleFactor = MIN(scaleFactor, 1.0);
    CGFloat targetWidth = imageSize.width * scaleFactor;
    CGFloat targetHeight = imageSize.height * scaleFactor;
    
    targetSize = CGSizeMake(floor(targetWidth), floor(targetHeight));
    
    UIGraphicsBeginImageContext(targetSize);
    [sourceImage drawInRect:CGRectMake(0, 0, ceilf(targetWidth), ceilf(targetHeight))];
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    if (newImage == nil) {
        newImage = sourceImage;
    }
    UIGraphicsEndImageContext();
    return newImage;
}


/**
 *  图片缩放
 *
 *  @param targetSize  缩放尺寸
 *  @param highQuality 图片缩放质量是否高
 *
 *  @return 返回缩放后的图片
 */
- (UIImage *)scaleToSize:(CGSize)targetSize highQuality:(BOOL)highQuality {
    if (highQuality) {
        targetSize = CGSizeMake(2 * targetSize.width, 2 * targetSize.height);
    }
    return [self scaleToSize:targetSize];
}


/**
 *  图片缩放
 *
 *  @param mmaxSize 缩放到的最大尺寸
 *
 *  @return 返回缩放后的图片
 */
- (UIImage *)scaleToMaxSize:(CGSize)maxSize {
    CGFloat width = maxSize.width;
    CGFloat height = maxSize.height;
    
    CGFloat oldWidth = self.size.width;
    CGFloat oldHeight = self.size.height;
    
    CGFloat widthFactor = width / oldWidth;
    CGFloat heightFactor = height / oldHeight;
    
    CGFloat scaleFactor = oldWidth > oldHeight ? widthFactor : heightFactor;
    if (scaleFactor > 1.0) {
        return self;
    }
    
    CGFloat newWidth = scaleFactor * oldWidth;
    CGFloat newHeight = scaleFactor * oldHeight;
    CGSize newSize = CGSizeMake(newWidth, newHeight);
    
    UIGraphicsBeginImageContextWithOptions(newSize, NO, 0.0);
    [self drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}


@end
