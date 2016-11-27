//
//  BlankPageController.m
//  ProjectBase
//
//  Created by 向云飞 on 16/8/4.
//  Copyright © 2016年 向云飞. All rights reserved.
//

#import "BlankPageController.h"

@interface BlankPageController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation BlankPageController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.tableView];
    [self settingAutoLayout];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.tableView.scrollEnabled = NO;
        [self.tableView configBlankPage:EaseBlankPageTypeNoNetWork hasData:NO hasError:YES reloadButtonBlock:^(id sender) {
            DBLog(@"%@====",sender);
            self.tableView.scrollEnabled = YES;
        }];
    });
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    cell.textLabel.text  = @"测试";
    
    return cell;
}


- (void)settingAutoLayout {
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

@end
