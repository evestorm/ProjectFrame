//
//  LoginController.m
//  ProjectBase
//
//  Created by 向云飞 on 2016/10/17.
//  Copyright © 2016年 向云飞. All rights reserved.
//

#import "LoginController.h"
#import "LoginViewModel.h"

@interface LoginController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *loginTableView;

@property (nonatomic, strong) NSArray *loginMethods;

@end

@implementation LoginController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.loginTableView];
    [self.loginTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.loginMethods.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *login = @"loginMethod";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:login];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:login];
    }
    
    cell.textLabel.text = self.loginMethods[indexPath.row];
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        [LoginViewModel weChatLoginViewController:self success:^{
            
        } failure:^(id failure) {
            
        }];
    }else if (indexPath.row == 1) {
        [LoginViewModel QQLoginViewController:self success:^{
            
        } failure:^(id failure) {
            
        }];
    }else {
        [LoginViewModel weiboLoginViewController:self success:^{
            
        } failure:^(id failure) {
            
        }];
    }
}


- (UITableView *)loginTableView {
    if (!_loginTableView) {
        _loginTableView = [[UITableView alloc] init];
        _loginTableView.dataSource = self;
        _loginTableView.delegate = self;
    }
    return _loginTableView;
}

- (NSArray *)loginMethods {
    if (!_loginMethods) {
        _loginMethods = [[NSArray alloc] init];
        _loginMethods = @[@"微信",@"QQ",@"微博"];
    }
    return _loginMethods;
}


@end
