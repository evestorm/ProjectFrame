//
//  ViewController.m
//  ProjectBase
//
//  Created by 向云飞 on 16/7/26.
//  Copyright © 2016年 向云飞. All rights reserved.
//

#import "ViewController.h"

#import "BlankPageController.h"
#import "LoadingViewController.h"
#import "CustomAlertController.h"
#import "DropDownMenuController.h"
#import "BadgeViewController.h"
#import "ActionSheetController.h"
#import "LoginController.h"
#import "StarRateViewController.h"
#import "CountDownViewController.h"
#import "FadeLabelController.h"


@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSArray *libsArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.tableView];
    [self settingAutoLayout];
    
    [self.tableView reloadData];
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.libsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"identifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.textLabel.text = self.libsArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        BlankPageController *blank = [[BlankPageController alloc] init];
        [self.navigationController pushViewController:blank animated:YES];
    }
    if (indexPath.row == 1) {
        LoadingViewController *loading = [[LoadingViewController alloc] init];
        [self.navigationController pushViewController:loading animated:YES];
    }
    if (indexPath.row == 2) {
        CustomAlertController *custom = [[CustomAlertController alloc] init];
        [self.navigationController pushViewController:custom animated:YES];
    }
    if (indexPath.row == 3) {
        DropDownMenuController *dropDown = [[DropDownMenuController alloc] init];
        [self.navigationController pushViewController:dropDown animated:YES];
    }
    if (indexPath.row == 4) {
        BadgeViewController *badge = [[BadgeViewController alloc] init];
        [self.navigationController pushViewController:badge animated:YES];
    }
    if (indexPath.row == 5) {
        ActionSheetController *actionSheet = [[ActionSheetController alloc] init];
        [self.navigationController pushViewController:actionSheet animated:YES];
    }
    if (indexPath.row == 6) {
        LoginController *login = [[LoginController alloc] init];
        [self.navigationController pushViewController:login animated:YES];
    }
    if (indexPath.row == 7) {
        StarRateViewController *StarRate = [[StarRateViewController alloc] init];
        [self.navigationController pushViewController:StarRate animated:YES];
    }
    if (indexPath.row == 8) {
        CountDownViewController *CountDown = [[CountDownViewController alloc] init];
        [self.navigationController pushViewController:CountDown animated:YES];
    }
    if (indexPath.row == 9) {
        FadeLabelController *fade = [[FadeLabelController alloc] init];
        [self.navigationController pushViewController:fade animated:YES];
    }
    
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.dataSource = self;
        _tableView.delegate = self;
    }
    return _tableView;
}

- (NSArray *)libsArray {
    if (!_libsArray) {
        _libsArray = [[NSArray alloc] init];
        _libsArray = @[@"空白页提示",@"加载动画",@"通用弹窗",@"下拉菜单",@"提示小圆点",@"ActionSheet",@"登录",@"星星评分",@"倒计时",@"渐隐渐现Label"];
    }
    return _libsArray;
}

- (void)settingAutoLayout {
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
}



@end
