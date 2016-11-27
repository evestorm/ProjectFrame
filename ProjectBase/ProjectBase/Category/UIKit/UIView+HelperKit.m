//
//  UIView+HelperKit.m
//  ProjectBase
//
//  Created by 向云飞 on 16/7/26.
//  Copyright © 2016年 向云飞. All rights reserved.
//

#import "UIView+HelperKit.h"
#import <objc/runtime.h>


#pragma mark - 设置控件尺寸
@implementation UIView (HelperKit)

- (CGFloat)x {
    return self.frame.origin.x;
}

- (void)setX:(CGFloat)x {
    self.frame = CGRectMake(x, self.frame.origin.x, self.frame.size.width, self.frame.size.height);
}

- (CGFloat)y {
    return self.frame.origin.y;
}

- (void)setY:(CGFloat)y {
    self.frame = CGRectMake(self.frame.origin.x, y, self.frame.size.width, self.frame.size.height);
}

- (CGFloat)width {
    return self.frame.size.width;
}

- (void)setWidth:(CGFloat)width {
    CGRect newFrame = CGRectMake(self.x, self.y, width, self.height);
    self.frame = newFrame;
}

- (CGFloat)height {
    return self.frame.size.height;
}

- (void)setHeight:(CGFloat)height {
    CGRect newFrame = CGRectMake(self.x, self.y, self.width, height);
    self.frame = newFrame;
}



- (CGFloat)centerX {
    return self.center.x;
}

- (void)setCenterX:(CGFloat)centerX {
    CGPoint center = CGPointMake(self.centerX, self.centerY);
    center.x = centerX;
    self.center = center;
}

- (CGFloat)centerY {
    return self.center.y;
}

- (void)setCenterY:(CGFloat)centerY {
    CGPoint center = CGPointMake(self.centerX, self.centerY);
    center.y = centerY;
    self.center = center;
}


- (CGPoint)origin {
    return self.frame.origin;
}

- (void)setOrigin:(CGPoint)origin {
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

- (CGSize)size {
    return self.frame.size;
}

- (void)setSize:(CGSize)size {
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (CGFloat)bottomY {
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setBottomY:(CGFloat)bottomY {
    self.y = bottomY - self.height;
}

- (CGFloat)rightX {
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setRightX:(CGFloat)rightX {
    self.x = rightX - self.width;
}

@end


#pragma mark - 设置手势方法
static char kActionHandlerTapBlockKey;
static char kActionHandlerTapGestureKey;
static char kActionHandlerLongPressBlockKey;
static char kActionHandlerLongPressGestureKey;

@implementation UIView (GestureBlock)

/**
 *  添加tap手势
 *
 *  @param block block 代码块
 */
- (void)addTapGestureWithBlock:(GestureActionBlock)block {
    
    self.userInteractionEnabled = YES;
    UITapGestureRecognizer *gesture = objc_getAssociatedObject(self, &kActionHandlerTapGestureKey);
    if (!gesture) {
        gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleActionForGesture:)];
        [self addGestureRecognizer:gesture];
        objc_setAssociatedObject(self, &kActionHandlerTapBlockKey, gesture, OBJC_ASSOCIATION_RETAIN);
    }
    objc_setAssociatedObject(self, &kActionHandlerTapBlockKey, block, OBJC_ASSOCIATION_COPY);
}


- (void)handleActionForGesture:(UITapGestureRecognizer *)gesture {
    if (gesture.state == UIGestureRecognizerStateRecognized) {
        GestureActionBlock block = objc_getAssociatedObject(self, &kActionHandlerTapBlockKey);
        if (block) {
            block(gesture);
        }
    }
}



/**
 *  添加长按手势
 *
 *  @param block block 代码块
 */
- (void)addLongPressActionWithBlock:(GestureActionBlock)block {
    self.userInteractionEnabled = YES;
    UILongPressGestureRecognizer *longPress = objc_getAssociatedObject(self, &kActionHandlerLongPressGestureKey);
    if (!longPress) {
        longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressActionForGesture:)];
        [self addGestureRecognizer:longPress];
        objc_setAssociatedObject(self, &kActionHandlerLongPressGestureKey, longPress, OBJC_ASSOCIATION_RETAIN);
    }
    objc_setAssociatedObject(self, &kActionHandlerLongPressBlockKey, block, OBJC_ASSOCIATION_COPY);
    
}

- (void)longPressActionForGesture:(UITapGestureRecognizer *)gesture {
    if (gesture.state == UIGestureRecognizerStateRecognized) {
        GestureActionBlock block = objc_getAssociatedObject(self, &kActionHandlerLongPressBlockKey);
        if (block) {
            block(gesture);
        }
    }
}

@end













