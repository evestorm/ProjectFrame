//
//  ActionSheetController.m
//  ProjectBase
//
//  Created by 向云飞 on 16/9/3.
//  Copyright © 2016年 向云飞. All rights reserved.
//

#import "ActionSheetController.h"

#import "ActionSheet.h"


@implementation ActionSheetController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
    [button addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
}

- (void)buttonClick {
    [[[ActionSheet alloc] initWithMessageArray:@[@"视频",@"拍照",@"相册"] cancel:@"取消" clickBlock:^(NSInteger selectedIndex, NSString *message) {
        NSLog(@"%ld====%@",(long)selectedIndex,message);
    } cancelBlock:^{
        NSLog(@"cancel");
    }] showActionSheet];
}

@end
