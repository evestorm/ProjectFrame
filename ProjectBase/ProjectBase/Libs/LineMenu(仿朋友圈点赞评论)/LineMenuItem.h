//
//  LineMenuItem.h
//  ProjectBase
//
//  Created by 向云飞 on 16/8/9.
//  Copyright © 2016年 向云飞. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LineMenuItem : NSObject<NSCopying>

- (instancetype)initWithTitle:(NSString *)title image:(UIImage *)image selectedImage:(UIImage *)selectedImage;

@end
