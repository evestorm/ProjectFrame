//
//  UIView+PressMenu.h
//  ProjectBase
//
//  Created by 向云飞 on 16/8/11.
//  Copyright © 2016年 向云飞. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (PressMenu)

@property (nonatomic, strong) NSArray *menuTitles;
@property (nonatomic, strong) UILongPressGestureRecognizer *longPressGesture;
@property (nonatomic, copy) void(^menuClickedBlock)(NSInteger index,NSString *title);
@property (nonatomic, strong) UIMenuController *menuVC;


/**
 *  添加菜单(针对不能交互的控件 UIImageView)
 *
 *  @param menuTitles 菜单项数组
 *  @param block      block返回
 */
- (void)addPressMenuTitles:(NSArray *)menuTitles menuClickedBlock:(void(^)(NSInteger index,NSString *title))block;

/**
 *  添加菜单
 *
 *  @param menuTitles 菜单项数组
 *  @param block      block返回
 */
- (void)showMenuTitles:(NSArray *)menuTitles menuClickedBlock:(void(^)(NSInteger index, NSString *title))block;

- (BOOL)isMenuVCVisible;

- (void)removePressMenu;


//UIButton *button = (UIButton *)sender;
//
//if ([button isMenuVCVisible]) {
//    [button removePressMenu];
//    return;
//}
//
//[button showMenuTitles:@[@"拷贝",@"删除"] menuClickedBlock:^(NSInteger index, NSString *title) {
//    if ([title isEqualToString:@"拷贝"]) {
//        DBLog(@"拷贝");
//    }else {
//        DBLog(@"删除");
//    }
//}];


@end
