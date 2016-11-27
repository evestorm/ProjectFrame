//
//  RefreshManager.m
//  ProjectBase
//
//  Created by 向云飞 on 2016/10/7.
//  Copyright © 2016年 向云飞. All rights reserved.
//

#import "RefreshManager.h"

typedef NS_ENUM(NSInteger,RefreshState) {
    RefreshBegin = 0,
    RefreshEnding
};

@implementation RefreshManager


/**
 Block 回调刷新
 
 @param viewController    要刷新的视图控制器
 @param headerOrFooter    要刷新头部还是尾部
 @param autoRefreshFooter 是否自动刷新尾部
 @param refreshingBlock   刷新之后的Block回调
 */
+ (void)refreshNormalWithBlockForViewController:(UIViewController *)viewController ofHeaderOrFooter:(HeaderOrFooterRefresh)headerOrFooter autoRefreshFooter:(BOOL)autoRefreshFooter refreshingBlock:(Refresh)refreshingBlock {
    if (headerOrFooter == HeaderRefresh) {
        MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            refreshingBlock();
        }];
        [self setHeader:header ForViewController:viewController refreshState:RefreshBegin];
    }else {
        if (autoRefreshFooter == YES) {
            MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
                refreshingBlock();
            }];
            footer.automaticallyHidden = YES;
            [self setFooter:footer ForViewController:viewController refreshState:RefreshBegin];
        }else {
            MJRefreshBackNormalFooter *footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
                refreshingBlock();
            }];
            footer.automaticallyHidden = YES;
            [self setFooter:footer ForViewController:viewController refreshState:RefreshBegin];
        }
    }
}


/**
 带方法的刷新
 
 @param viewController    要刷新的视图控制器
 @param refreshingAction  刷新方法
 @param headerOrFooter    要刷新头部还是尾部
 @param autoRefreshFooter 是否自动刷新尾部
 */
+ (void)refreshNormalWithSelectorForViewController:(UIViewController *)viewController refreshingAction:(SEL)refreshingAction ofHeaderOrFooter:(HeaderOrFooterRefresh)headerOrFooter autoRefreshFooter:(BOOL)autoRefreshFooter {
    if (headerOrFooter == HeaderRefresh) {
        MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:viewController refreshingAction:refreshingAction];
        [self setHeader:header ForViewController:viewController refreshState:RefreshBegin];
    }else {
        if (autoRefreshFooter == YES) {
            MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:viewController refreshingAction:refreshingAction];
            footer.automaticallyHidden = YES;
            [self setFooter:footer ForViewController:viewController refreshState:RefreshBegin];
        }else {
            MJRefreshBackNormalFooter *footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:viewController refreshingAction:refreshingAction];
            footer.automaticallyHidden = YES;
            [self setFooter:footer ForViewController:viewController refreshState:RefreshBegin];
        }
    }
}



/**
 GIF动画-Block回调刷新
 
 @param viewController    要刷新的视图控制器
 @param headerOrFooter    要刷新头部还是尾部
 @param idleImages        普通状态的动画图片
 @param pullingImages     即将刷新状态的动画图片（一松开就会刷新的状态）
 @param refreshingImages  正在刷新状态的动画图片
 @param noDataImages      没有更多数据的动画图片
 @param autoRefreshFooter 是否自动刷新尾部
 @param refreshingBlock   刷新Block回调
 */
+ (void)refreshGifWithBlockForViewController:(UIViewController *)viewController ofHeaderOrFooter:(HeaderOrFooterRefresh)headerOrFooter idleImages:(NSArray *)idleImages pullingImages:(NSArray *)pullingImages refreshingImages:(NSArray *)refreshingImages noDataImages:(NSArray *)noDataImages autoRefreshFooter:(BOOL)autoRefreshFooter refreshingBlock:(Refresh)refreshingBlock {
    if (headerOrFooter == HeaderRefresh) {
        MJRefreshGifHeader *header = [MJRefreshGifHeader headerWithRefreshingBlock:^{
            refreshingBlock();
        }];
        [header setImages:idleImages forState:MJRefreshStateIdle];
        [header setImages:pullingImages forState:MJRefreshStatePulling];
        [header setImages:refreshingImages forState:MJRefreshStateRefreshing];
        [self setHeader:header ForViewController:viewController refreshState:RefreshBegin];
    }else {
        if (autoRefreshFooter == YES) {
            MJRefreshAutoGifFooter *footer = [MJRefreshAutoGifFooter footerWithRefreshingBlock:^{
                refreshingBlock();
            }];
            [footer setImages:idleImages forState:MJRefreshStateIdle];
            [footer setImages:pullingImages forState:MJRefreshStatePulling];
            [footer setImages:refreshingImages forState:MJRefreshStateRefreshing];
            [footer setImages:noDataImages forState:MJRefreshStateNoMoreData];
            footer.automaticallyHidden = YES;
            [self setFooter:footer ForViewController:viewController refreshState:RefreshBegin];
        }else {
            MJRefreshBackGifFooter *footer = [MJRefreshBackGifFooter footerWithRefreshingBlock:^{
                refreshingBlock();
            }];
            [footer setImages:idleImages forState:MJRefreshStateIdle];
            [footer setImages:pullingImages forState:MJRefreshStatePulling];
            [footer setImages:refreshingImages forState:MJRefreshStateRefreshing];
            [footer setImages:noDataImages forState:MJRefreshStateNoMoreData];
            footer.automaticallyHidden = YES;
            [self setFooter:footer ForViewController:viewController refreshState:RefreshBegin];
        }
    }
}




/**
 Gif动画-带方法的刷新
 
 @param viewController    要刷新的视图控制器
 @param refreshingAction  刷新方法
 @param headerOrFooter    要刷新头部还是尾部
 @param idleImages        普通状态的动画图片
 @param pullingImages     即将刷新状态的动画图片（一松开就会刷新的状态）
 @param refreshingImages  正在刷新状态的动画图片
 @param noDataImages      没有更多数据的动画图片
 @param autoRefreshFooter 是否自动刷新尾部
 */
+ (void)refreshGifWithSelectorForViewController:(UIViewController *)viewController refreshingAction:(SEL)refreshingAction ofHeaderOrFooter:(HeaderOrFooterRefresh)headerOrFooter idleImages:(NSArray *)idleImages pullingImages:(NSArray *)pullingImages refreshingImages:(NSArray *)refreshingImages noDataImages:(NSArray *)noDataImages autoRefreshFooter:(BOOL)autoRefreshFooter {
    if (headerOrFooter == HeaderRefresh) {
        MJRefreshGifHeader *header = [MJRefreshGifHeader headerWithRefreshingTarget:viewController refreshingAction:refreshingAction];
        [header setImages:idleImages forState:MJRefreshStateIdle];
        [header setImages:pullingImages forState:MJRefreshStatePulling];
        [header setImages:refreshingImages forState:MJRefreshStateRefreshing];
        [self setHeader:header ForViewController:viewController refreshState:RefreshBegin];
    }else {
        if (autoRefreshFooter == YES) {
            MJRefreshAutoGifFooter *footer = [MJRefreshAutoGifFooter footerWithRefreshingTarget:viewController refreshingAction:refreshingAction];
            [footer setImages:idleImages forState:MJRefreshStateIdle];
            [footer setImages:pullingImages forState:MJRefreshStatePulling];
            [footer setImages:refreshingImages forState:MJRefreshStateRefreshing];
            [footer setImages:noDataImages forState:MJRefreshStateNoMoreData];
            footer.automaticallyHidden = YES;
            [self setFooter:footer ForViewController:viewController refreshState:RefreshBegin];
        }else {
            MJRefreshBackGifFooter *footer = [MJRefreshBackGifFooter footerWithRefreshingTarget:viewController refreshingAction:refreshingAction];
            [footer setImages:idleImages forState:MJRefreshStateIdle];
            [footer setImages:pullingImages forState:MJRefreshStatePulling];
            [footer setImages:refreshingImages forState:MJRefreshStateRefreshing];
            [footer setImages:noDataImages forState:MJRefreshStateNoMoreData];
            footer.automaticallyHidden = YES;
            [self setFooter:footer ForViewController:viewController refreshState:RefreshBegin];
        }
    }
}




/**
 结束刷新
 
 @param viewController 要结束刷新的视图控制器
 @param headerOrFooter 要结束刷新头部还是尾部
 */
+ (void)endRefreshForViewController:(UIViewController *)viewController ofHeaderOrFooter:(HeaderOrFooterRefresh)headerOrFooter {
    if (headerOrFooter == HeaderRefresh) {
        [self setHeader:nil ForViewController:viewController refreshState:RefreshEnding];
    }else {
        [self setFooter:nil ForViewController:viewController refreshState:RefreshEnding];
    }
}



#pragma mark - private methods
+ (void)setHeader:(MJRefreshHeader *)header ForViewController:(UIViewController *)viewController refreshState:(RefreshState)state {
    if ([viewController isKindOfClass:[UITableViewController class]]) {
        UITableViewController *tableViewController = (UITableViewController *)viewController;
        if (state == RefreshBegin) {
            tableViewController.tableView.mj_header = header;
            [header beginRefreshing];
        }else {
            [tableViewController.tableView.mj_header endRefreshing];
        }
        
    }
    
    if ([viewController isKindOfClass:[UICollectionViewController class]]) {
        UICollectionViewController *collectionViewController = (UICollectionViewController *)viewController;
        if (state == RefreshBegin) {
            collectionViewController.collectionView.mj_header = header;
            [header beginRefreshing];
        }else {
            [collectionViewController.collectionView.mj_header endRefreshing];
        }
        
    }
    
    if ([viewController isKindOfClass:[UIViewController class]]) {
        for (UIView *refreshView in viewController.view.subviews) {
            if ([refreshView isKindOfClass:[UITableView class]]) {
                UITableView *tableView = (UITableView *)refreshView;
                if (state == RefreshBegin) {
                    tableView.mj_header = header;
                    [header beginRefreshing];
                }else {
                    [tableView.mj_header endRefreshing];
                }
            }
            
            if ([refreshView isKindOfClass:[UICollectionView class]]) {
                UICollectionView *collection = (UICollectionView *)refreshView;
                if (state == RefreshBegin) {
                    collection.mj_header = header;
                    [header beginRefreshing];
                }else {
                    [collection.mj_header endRefreshing];
                }
            }
        }
    }
}

+ (void)setFooter:(MJRefreshFooter *)footer ForViewController:(UIViewController *)viewController refreshState:(RefreshState)state {
    if ([viewController isKindOfClass:[UITableViewController class]]) {
        UITableViewController *tableViewController = (UITableViewController *)viewController;
        if (state == RefreshBegin) {
            tableViewController.tableView.mj_footer = footer;
            [footer beginRefreshing];
        }else {
            [tableViewController.tableView.mj_footer endRefreshing];
        }
        
    }
    
    if ([viewController isKindOfClass:[UICollectionViewController class]]) {
        UICollectionViewController *collectionViewController = (UICollectionViewController *)viewController;
        if (state == RefreshBegin) {
            collectionViewController.collectionView.mj_footer = footer;
            [footer beginRefreshing];
        }else {
            [collectionViewController.collectionView.mj_footer endRefreshing];
        }
    }
    
    if ([viewController isKindOfClass:[UIViewController class]]) {
        for (UIView *refreshView in viewController.view.subviews) {
            if ([refreshView isKindOfClass:[UITableView class]]) {
                UITableView *tableView = (UITableView *)refreshView;
                if (state == RefreshBegin) {
                    tableView.mj_footer = footer;
                    [footer beginRefreshing];
                }else {
                    [tableView.mj_footer endRefreshing];
                }
            }
            if ([refreshView isKindOfClass:[UICollectionView class]]) {
                UICollectionView *collection = (UICollectionView *)refreshView;
                if (state == RefreshBegin) {
                    collection.mj_footer = footer;
                    [footer beginRefreshing];
                }else {
                    [collection.mj_footer endRefreshing];
                }
            }
        }
    }
}

@end
