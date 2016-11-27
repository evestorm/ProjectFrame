//
//  DropDownMenuView.h
//  ProjectBase
//
//  Created by 向云飞 on 16/8/16.
//  Copyright © 2016年 向云飞. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^dropMenuCallBack)(NSUInteger index,id info);

typedef NS_ENUM(NSInteger,dropDownType) {
    dropDownType_title = 0,     //navBar的titleView
    dropDownType_leftItem = 1,  //leftBarItem
    dropDownType_rightItem = 2  //rightBarItem
};

@interface DropDownMenuView : UIView

+ (instancetype)dropdownMenuViewWithType:(dropDownType)dropDownType frame:(CGRect)frame dropdownItems:(NSArray *)dropdownItems icon:(NSString *)icon;
+ (instancetype)dropdownMenuViewForNavbarTitleViewWithFrame:(CGRect )frame dropdownItems:(NSArray *)dropdownItems;

/**< 当前Nav导航栏*/
@property(weak ,nonatomic) UINavigationController *currentNav;

/**< 当前选中index 默认是0*/
@property (assign ,nonatomic) NSUInteger selectedIndex;

/**< titleColor 标题字体颜色  默认 白色*/
@property (strong, nonatomic) UIColor *titleColor;

/**< titleFont  标题字体  默认 system 17*/
@property (strong, nonatomic) UIFont  *titleFont;

/**< 下拉菜单的宽度  默认80.f*/
@property (assign, nonatomic) CGFloat dropWidth;

/**< 下拉菜单 cell 颜色  默认 白色*/
@property (strong, nonatomic) UIColor *cellColor;

/**< 下拉菜单 cell 字体颜色 默认 白色*/
@property (strong, nonatomic) UIColor *textColor;

/**< 下拉菜单 cell 字体大小 默认 system 17.f*/
@property (strong, nonatomic) UIFont  *textFont;

/**< 下拉菜单 cell seprator color 默认 白色*/
@property (strong, nonatomic) UIColor *cellSeparatorColor;

/**< 下拉菜单 cell accessory check mark color 默认 默认白色*/
@property (strong, nonatomic) UIColor *cellAccessoryCheckmarkColor;

/**< 下拉菜单 cell 高度 默认 40.f*/
@property (assign, nonatomic) CGFloat cellHeight;

/**< 下拉菜单 弹出动画执行时间 默认 0.4s*/
@property (assign, nonatomic) CGFloat animationDuration;

/**< 下拉菜单 cell 是否显示选中按钮  默认 NO*/
@property (assign, nonatomic) BOOL    showAccessoryCheckmark;

/**< 默认幕布透明度 opacity 默认 0.3f*/
@property (assign, nonatomic) CGFloat backgroundAlpha;

@end

@interface DropDownItem : NSObject

/**< 回调 callBack*/
@property (nonatomic, copy) dropMenuCallBack callBack;

/**< title*/
@property (copy, nonatomic) NSString *title;

/**< icon*/
@property (copy, nonatomic) NSString *iconName;

/**< selected*/
@property (assign, nonatomic)  BOOL isSelected;

/**< info 自定义参数*/
@property (strong, nonatomic) id info;

+ (instancetype)itemWithTitle:(NSString *)title iconName:(NSString *)iconName callBack:(dropMenuCallBack)callBack;

+ (instancetype)itemWithTitle:(NSString *)title callBack:(dropMenuCallBack)callBack;

+ (instancetype)Item;


@end



#pragma mark - 使用方法
//DropDownItem *item0 = [DropDownItem itemWithTitle:@"dropdownItem0" callBack:^(NSUInteger index, id info) {
//    NSLog(@"dropdownItem%lu",(unsigned long)index);
//}];
//DropDownItem *item1 = [DropDownItem itemWithTitle:@"dropdownItem1" callBack:^(NSUInteger index, id info) {
//    NSLog(@"dropdownItem%lu",(unsigned long)index);
//}];
//DropDownItem *item2 = [DropDownItem itemWithTitle:@"dropdownItem2" callBack:^(NSUInteger index, id info) {
//    NSLog(@"dropdownItem%lu",(unsigned long)index);
//}];
//DropDownItem *item3 = [DropDownItem itemWithTitle:@"Item3" callBack:^(NSUInteger index, id info) {
//    NSLog(@"dropdownItem%lu",(unsigned long)index);
//}];
//DropDownMenuView *menuView = [DropDownMenuView dropdownMenuViewForNavbarTitleViewWithFrame:CGRectMake(0, 0, 200.f, 44.f) dropdownItems:@[item0,item1,item2,item3]];
//menuView.currentNav = self.navigationController;
//menuView.dropWidth = 150.f;
//menuView.titleFont = [UIFont systemFontOfSize:18.f];
//menuView.titleColor = [UIColor blueColor];
//menuView.textColor = [UIColor redColor];
//menuView.textFont = [UIFont systemFontOfSize:13.f];
//menuView.textFont = [UIFont systemFontOfSize:14.f];
//menuView.animationDuration = 0.2f;
//menuView.cellSeparatorColor = [UIColor orangeColor];
//self.navigationItem.titleView = menuView;

