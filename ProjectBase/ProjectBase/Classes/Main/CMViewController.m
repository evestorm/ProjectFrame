//
//  CMViewController.m
//  ProjectBase
//
//  Created by 向云飞 on 16/8/4.
//  Copyright © 2016年 向云飞. All rights reserved.
//

#import "CMViewController.h"

#define kNaviStackMax  99

@implementation CMViewController

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (id)init
{
    if ((self = [super init])) {
        self.naviBackIndex = kNaviStackMax;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    _titleView = [[UIView alloc] init];
    _titleView.backgroundColor = [UIColor clearColor];
    _titleView.frame = CGRectMake(0, 0, 200, 44);
    
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.backgroundColor = [UIColor clearColor];
    _titleLabel.frame = CGRectMake(0, 0, 200, 44);
    _titleLabel.font = [UIFont fontWithSize:18.0f];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.textColor = [UIColor whiteColor];
    [_titleView addSubview:_titleLabel];
    
    
    [self.navigationItem setTitle:nil];
    [self.navigationItem setTitleView:_titleView];
    
    
}


- (void)_handleEndEditing {
    [self.view endEditing:YES];
}

- (void)hideNavCanBack {
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.delegate = nil;
    }
}

- (void)removeController:(Class)viewControllerClass {
    
    NSMutableArray *viewControllers = [[NSMutableArray alloc] initWithArray:self.navigationController.viewControllers];
    for (int i = 0; i < viewControllers.count - 1; i ++) {
        if ([viewControllers[i] class] == viewControllerClass) {
            [viewControllers removeObjectAtIndex:i];
            if (SYSTEM_VERSION_LESS_THAN(@"9.0")) {
                self.navigationController.viewControllers = viewControllers;
            } else {
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    self.navigationController.viewControllers = viewControllers;
                });
            }
            return;
        }
    }
}


//页面返回事件
- (void)_handleViewBack {
    if ([self.navigationController.viewControllers count] == 1) {
        [self dismissViewControllerAnimated:YES completion:^{ }];
        return;
    }
    
    UIViewController *viewController = [self viewControllerWithNaviIndex:self.naviBackIndex];
    if (viewController) {
        [self.navigationController popToViewController:viewController animated:YES];
    } else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}


//从导航栏栈中获取UIViewController
- (UIViewController *)viewControllerWithNaviIndex:(int)naviIndex {
    NSArray *viewControllers = self.navigationController.viewControllers;
    
    if (naviIndex < [viewControllers count] - 1) {
        return self.navigationController.viewControllers[naviIndex];
    }
    if ([viewControllers count] - 2 > 0) {
        return self.navigationController.viewControllers[[viewControllers count] - 2];
    }
    
    return nil;
}




#pragma mark - UIViewControllerRotation

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (BOOL)shouldAutorotate {
    return NO;
}


#pragma mark - ---------------- 方法 ------------------
#pragma mark - 设置刷新控件
- (void)setRefreshControl:(UIScrollView *)scrollView refreshAction:(SEL)refreshAction {
    MJRefreshStateHeader *header = [MJRefreshStateHeader headerWithRefreshingTarget:self refreshingAction:refreshAction];
    [header setTitle:@"正在加载..." forState:MJRefreshStateRefreshing];
    header.stateLabel.font = [UIFont systemFontOfSize:12.0f];
    header.lastUpdatedTimeLabel.hidden = YES;
    scrollView.mj_header = header;
}

#pragma mark - 设置加载控件
- (void)setUploadControl:(UIScrollView *)scrollView uploadAction:(SEL)uploadAction {
    MJRefreshBackNormalFooter *footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:uploadAction];
    [footer setTitle:@"加载更多内容..." forState:MJRefreshStateRefreshing];
    footer.stateLabel.font = [UIFont systemFontOfSize:12.0f];
    scrollView.mj_footer = footer;
    [footer setTitle:@"没有更多数据了" forState:MJRefreshStateNoMoreData];
}

@end
