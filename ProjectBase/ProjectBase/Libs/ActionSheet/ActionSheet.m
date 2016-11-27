//
//  ActionSheet.m
//  ProjectBase
//
//  Created by 向云飞 on 16/9/3.
//  Copyright © 2016年 向云飞. All rights reserved.
//

#import "ActionSheet.h"
#import "ActionSheetCell.h"

//static CGFloat const kLabelTag = 10000;

static CGFloat const cellHeight = 44.0f;

static CGFloat const sectionHeight = 8.0f;

@interface ActionSheet ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) NSArray *messageArray;
@property (nonatomic, copy) NSString *cancelString;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, assign) CGFloat tableViewHeight;
@property (nonatomic, copy) ActionSheetBlock clickBlock;
@property (nonatomic, copy) ActionSheetCancelBlock cancelBlock;

@end

@implementation ActionSheet

- (instancetype)initWithMessageArray:(NSArray<NSString *> *)messageArray cancel:(NSString *)cancel clickBlock:(ActionSheetBlock)clickBlock cancelBlock:(ActionSheetCancelBlock)cancelBlock {
    self = [super initWithFrame:[UIScreen mainScreen].bounds];
    if (self) {
        self.messageArray = messageArray;
        self.cancelString = cancel;
        self.clickBlock = clickBlock;
        self.cancelBlock = cancelBlock;
        
        //计算
        self.tableViewHeight = [self getTableViewHeight];
        
//        [self addViews];
//        [self settingAutoLayout];
        
//        [self showActionSheet];
        
    }
    return self;
}

- (instancetype)initWithMessageArray:(NSArray<NSString *> *)messageArray clickBlock:(ActionSheetBlock)clickBlock {
    self = [super initWithFrame:[UIScreen mainScreen].bounds];
    if (self) {
        self.messageArray = messageArray;
        self.cancelString = @"";
        self.clickBlock = clickBlock;
        
        //计算
        self.tableViewHeight = [self getTableViewHeight];
    }
    return self;
}


- (void)showActionSheet {
    
    [self addViews];
    [kKeyWindow addSubview:self];
    
    [UIView animateWithDuration:0.25 animations:^{
        self.bgView.alpha = 0.2;
        self.tableView.y = kScreen_Height - self.tableViewHeight;
    }];
    
}

- (void)dismissActionSheet {
    [UIView animateWithDuration:0.25 animations:^{
        self.bgView.alpha = 0.0;
        self.tableView.y = kScreen_Height;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        self.clickBlock = nil;
        self.cancelBlock = nil;
    }];
}


- (void)addViews {
    [self addSubview:self.bgView];
    [self addSubview:self.tableView];
}

#pragma mark - UITableViewDelegate,UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (self.cancelString.length > 0) {
        return 2;
    }
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return self.messageArray.count;
    }
    return (self.cancelString.length > 0 ? 1 : 0);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ActionSheetCell *cell = [ActionSheetCell cellWithTableView:tableView];
    if (indexPath.section == 0) {
        [cell setTitleText:self.messageArray[indexPath.row]];
    }else if (indexPath.section == 1) {
        [cell setTitleText:self.cancelString];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if (self.clickBlock) {
            self.clickBlock(indexPath.row,self.messageArray[indexPath.row]);
        }
    }else {
        if (self.cancelBlock) {
            self.cancelBlock();
        }
    }
    [self dismissActionSheet];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 0;
    }
    return self.cancelString.length > 0 ? sectionHeight : 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *headerView = [[UIView alloc] init];
    headerView.backgroundColor = [UIColor colorWithHexString:@"eeeeef"];
    headerView.alpha = 0.9;
    if (section == 0) {
        return headerView;
    }else if (section == 1) {
        headerView.frame = CGRectMake(0, 0, kScreen_Width, sectionHeight);
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([tableView respondsToSelector:@selector(setLayoutMargins:)])  {
        [tableView setLayoutMargins:UIEdgeInsetsZero];
    }
}


#pragma mark - private methods
- (CGFloat)getTableViewHeight {
    CGFloat messageHeight = self.messageArray.count * cellHeight;
    
    CGFloat spaceHeight = 0.0f;
    CGFloat cancelHeight = 0.0f;
    if (self.cancelString.length > 0) {
        spaceHeight = sectionHeight;
        cancelHeight = cellHeight;
    }
    
    return messageHeight + spaceHeight + cancelHeight;
    
}

#pragma mark - getter
- (UIView *)bgView {
    if (!_bgView) {
        _bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height)];
        _bgView.backgroundColor = [UIColor blackColor];
        _bgView.alpha = 0;
        UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissActionSheet)];
        [_bgView addGestureRecognizer:gesture];
    }
    return _bgView;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, kScreen_Height, kScreen_Width, self.tableViewHeight)];
        _tableView.dataSource = self;
        _tableView.delegate= self;
        _tableView.rowHeight = cellHeight;
        _tableView.scrollEnabled = NO;
        _tableView.backgroundColor = [UIColor clearColor];
    }
    return _tableView;
}

@end
