//
//  LineMenuItem.m
//  ProjectBase
//
//  Created by 向云飞 on 16/8/9.
//  Copyright © 2016年 向云飞. All rights reserved.
//

#import "LineMenuItem.h"

@interface LineMenuItem ()

@property (nonatomic, copy) NSString *title;
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, strong) UIImage *selectedImage;

@end

@implementation LineMenuItem

- (instancetype)initWithTitle:(NSString *)title image:(UIImage *)image selectedImage:(UIImage *)selectedImage {
    self = [super init];
    if (self) {
        _title = title;
        _image = image;
        _selectedImage = selectedImage;
    }
    return self;
}


- (id)copyWithZone:(NSZone *)zone {
    LineMenuItem *item = [[[LineMenuItem class] allocWithZone:zone] init];
    if (item) {
        item->_title = self.title;
        item->_image = self.image;
        item->_selectedImage = self.selectedImage;
    }
    return item;
}

@end
