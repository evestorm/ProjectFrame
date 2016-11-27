//
//  UIImageView+HelperKit.m
//  ProjectBase
//
//  Created by 向云飞 on 16/7/28.
//  Copyright © 2016年 向云飞. All rights reserved.
//

#import "UIImageView+HelperKit.h"

@implementation UIImageView (HelperKit)

/**
 *  根据文本创建二维码图片
 *
 *  @param text 文本内容
 *  @param size 二维码大小
 */
- (void)createBarCodeWithText:(NSString *)text withSize:(CGSize)size {
    //二维码滤镜
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    
    //恢复滤镜的默认属性
    [filter setDefaults];

    //将字符串转换成NSData
    NSData *data = [text dataUsingEncoding:NSUTF8StringEncoding];
    
    //通过KVO设置滤镜inoutmessage数据
    [filter setValue:data forKey:@"inputMessage"];
    
    //获得滤镜输出的图像
    CIImage *outputImage = [filter outputImage];
    
    //将CIImage转换成UIImage,并放大显示
    self.image = [self createNonInterpolatedUIImageFormCIImage:outputImage withSize:size];
}


- (UIImage *)createNonInterpolatedUIImageFormCIImage:(CIImage *)image withSize:(CGSize)size {
    CGRect extent = CGRectIntegral(image.extent);
    CGFloat scale = MIN(size.width/CGRectGetWidth(extent), size.height/CGRectGetHeight(extent));
    
    //创建bitmap
    
    size_t width = CGRectGetWidth(extent) * scale;
    
    size_t height = CGRectGetHeight(extent) * scale;
    
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    
    CIContext *context = [CIContext contextWithOptions:nil];
    
    CGImageRef bitmapImage = [context createCGImage:image fromRect:extent];
    
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    
    CGContextScaleCTM(bitmapRef, scale, scale);
    
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    
    //保存bitmap到图片
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    
    CGContextRelease(bitmapRef);
    
    CGImageRelease(bitmapImage);
    
    return [UIImage imageWithCGImage:scaledImage];
}


/**
 *  创建imageView动画
 *
 *  @param imageArray 图片名称数组
 *  @param duration   动画时长
 */
+ (instancetype)imageViewWithImageArray:(NSArray *)imageArray duration:(NSTimeInterval)duration {
    if (!imageArray.count) {
        return nil;
    }
    
    UIImageView *imageView = [UIImageView imageViewWithImageNamed:[imageArray objectAtIndex:0]];
    NSMutableArray *images = [NSMutableArray array];
    for (NSInteger i = 0; i < images.count; i ++) {
        UIImage *image = [UIImage imageNamed:[imageArray objectAtIndex:i]];
        [images addObject:image];
    }
    
    [imageView setImage:[images objectAtIndex:0]];
    [imageView setAnimationImages:images];
    [imageView setAnimationDuration:duration];
    [imageView setAnimationRepeatCount:0];
    
    return imageView;
    
}

/**
 *  根据bundle中的图片名创建imageView
 *
 *  @param imageName bundle中的图片名
 *
 *  @return imageView
 */
+ (instancetype)imageViewWithImageNamed:(NSString*)imageName {
    return [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
}

@end
