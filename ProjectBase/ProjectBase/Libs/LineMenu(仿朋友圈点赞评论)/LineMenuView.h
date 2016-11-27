//
//  LineMenuView.h
//  ProjectBase
//
//  Created by 向云飞 on 16/8/10.
//  Copyright © 2016年 向云飞. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LineMenuItem.h"

@protocol LineMenuViewDelegate <NSObject>

- (void)didTapMenuIndex:(NSInteger)index;

@end


@interface LineMenuView : NSObject


@property (nonatomic, strong) NSArray *menuItems; /**< 弹出菜单数组*/
@property (nonatomic, copy) void(^didTapMenuAtIndex)(NSInteger index);
@property (nonatomic, assign) BOOL menuVisible;

@property (nonatomic, weak) id<LineMenuViewDelegate> delegate;

+ (instancetype)shareLineMenu;

- (void)setTargetRect:(CGRect)targetRect inView:(UIView *)targetView;
- (void)setMenuVisible:(BOOL)menuVisible animated:(BOOL)animated;

@end


@interface ContainerWindow : UIWindow

@property (nonatomic, copy) void(^tapBeyondSubViewsBlock)();

@end


#pragma mark - 使用方式
//self.lineMenu = [LineMenuView shareLineMenu];
//LineMenuItem *item1 = [[LineMenuItem alloc] initWithTitle:@"赞" image:nil selectedImage:nil];
//LineMenuItem *item2 = [[LineMenuItem alloc] initWithTitle:@"评论" image:nil selectedImage:nil];
//
//self.lineMenu.menuItems = @[item1,item2];
//
//UIButton *button = sender;
//[self.lineMenu setTargetRect:button.frame inView:self.view];
//[self.lineMenu setMenuVisible:!self.lineMenu.menuVisible animated:YES];



