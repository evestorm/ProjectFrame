//
//  CountDownViewController.m
//  ProjectBase
//
//  Created by 向云飞 on 2016/10/22.
//  Copyright © 2016年 向云飞. All rights reserved.
//

#import "CountDownViewController.h"
#import "CountDownSimpleController.h"
#import "CountDownInCellViewController.h"

@interface CountDownViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *countDownTableView;

@end

@implementation CountDownViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.countDownTableView];
    [self.countDownTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *login = @"countdown";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:login];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:login];
    }
    
    if (indexPath.row == 0) {
        cell.textLabel.text = @"单独倒计时";
    }else {
        cell.textLabel.text = @"多行倒计时";
    }    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        CountDownSimpleController *simple = [[CountDownSimpleController alloc] init];
        [self.navigationController pushViewController:simple animated:YES];
    }else {
        CountDownInCellViewController *simple = [[CountDownInCellViewController alloc] init];
        [self.navigationController pushViewController:simple animated:YES];
    }
}


- (UITableView *)countDownTableView {
    if (!_countDownTableView) {
        _countDownTableView = [[UITableView alloc] init];
        _countDownTableView.dataSource = self;
        _countDownTableView.delegate = self;
    }
    return _countDownTableView;
}


@end
