//
//  DropDownMenuController.m
//  ProjectBase
//
//  Created by 向云飞 on 16/8/16.
//  Copyright © 2016年 向云飞. All rights reserved.
//

#import "DropDownMenuController.h"
#import "DropDownMenuView.h"

@interface DropDownMenuController ()

@end

@implementation DropDownMenuController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addTitleMenu];
    
}


- (void)addTitleMenu
{
    DropDownItem *item0 = [DropDownItem itemWithTitle:@"dropdownItem0" callBack:^(NSUInteger index, id info) {
        NSLog(@"dropdownItem%lu",(unsigned long)index);
    }];
    DropDownItem *item1 = [DropDownItem itemWithTitle:@"dropdownItem1" callBack:^(NSUInteger index, id info) {
        NSLog(@"dropdownItem%lu",(unsigned long)index);
    }];
    DropDownItem *item2 = [DropDownItem itemWithTitle:@"dropdownItem2" callBack:^(NSUInteger index, id info) {
        NSLog(@"dropdownItem%lu",(unsigned long)index);
    }];
    DropDownItem *item3 = [DropDownItem itemWithTitle:@"Item3" callBack:^(NSUInteger index, id info) {
        NSLog(@"dropdownItem%lu",(unsigned long)index);
    }];
    DropDownMenuView *menuView = [DropDownMenuView dropdownMenuViewForNavbarTitleViewWithFrame:CGRectMake(0, 0, 200.f, 44.f) dropdownItems:@[item0,item1,item2,item3]];
    menuView.currentNav = self.navigationController;
    menuView.dropWidth = 150.f;
    menuView.titleFont = [UIFont systemFontOfSize:18.f];
    menuView.titleColor = [UIColor blueColor];
    menuView.textColor = [UIColor redColor];
    menuView.textFont = [UIFont systemFontOfSize:13.f];
    menuView.textFont = [UIFont systemFontOfSize:14.f];
    menuView.animationDuration = 0.2f;
    menuView.cellSeparatorColor = [UIColor orangeColor];
    self.navigationItem.titleView = menuView;
    
}


@end
