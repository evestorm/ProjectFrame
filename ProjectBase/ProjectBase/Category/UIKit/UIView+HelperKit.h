//
//  UIView+HelperKit.h
//  ProjectBase
//
//  Created by 向云飞 on 16/7/26.
//  Copyright © 2016年 向云飞. All rights reserved.
//

#import <UIKit/UIKit.h>


#pragma mark - 设置控件尺寸
@interface UIView (HelperKit)

/**
 *  view.frame.orign.x
 */
@property (nonatomic, assign) CGFloat x;

/**
 *  view.frame.orign.y
 */
@property (nonatomic, assign) CGFloat y;

/**
 *  view.frame.size.width
 */
@property (nonatomic, assign) CGFloat width;

/**
 *  view.frame.size.height
 */
@property (nonatomic, assign) CGFloat height;

/**
 *  view.center.x
 */
@property (nonatomic, assign) CGFloat centerX;

/**
 *  view.center.y
 */
@property (nonatomic, assign) CGFloat centerY;

/**
 *  view.frame.orign
 */
@property (nonatomic, assign) CGPoint origin;

/**
 *  view.frame.size
 */
@property (nonatomic, assign) CGSize size;

/**
 *  view.frame.orign.y + view.frame.size.height
 */
@property (nonatomic, assign) CGFloat bottomY;

/**
 *  view.frame.orign.x + view.frame.size.width
 */
@property (nonatomic, assign) CGFloat rightX;

@end


#pragma mark - 设置手势方法
typedef void(^GestureActionBlock)(UIGestureRecognizer *gesture);
@interface UIView (GestureBlock)

/**
 *  添加tap手势
 *
 *  @param block block 代码块
 */
- (void)addTapGestureWithBlock:(GestureActionBlock)block;


/**
 *  添加长按手势
 *
 *  @param block block 代码块
 */
- (void)addLongPressActionWithBlock:(GestureActionBlock)block;

@end




















