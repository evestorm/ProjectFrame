//
//  UIImageView+HelperKit.h
//  ProjectBase
//
//  Created by 向云飞 on 16/7/28.
//  Copyright © 2016年 向云飞. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (HelperKit)

/**
 *  根据文本创建二维码图片
 *
 *  @param text 文本内容
 *  @param size 二维码大小
 */
- (void)createBarCodeWithText:(NSString *)text withSize:(CGSize)size;

/**
 *  创建imageView动画
 *
 *  @param imageArray 图片名称数组
 *  @param duration   动画时长
 */
+ (instancetype)imageViewWithImageArray:(NSArray *)imageArray duration:(NSTimeInterval)duration;


/**
 *  根据bundle中的图片名创建imageView
 *
 *  @param imageName bundle中的图片名
 *
 *  @return imageView
 */
+ (instancetype)imageViewWithImageNamed:(NSString*)imageName;

@end
