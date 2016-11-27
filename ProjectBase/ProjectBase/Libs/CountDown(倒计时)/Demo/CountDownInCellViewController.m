//
//  CountDownInCellViewController.m
//  ProjectBase
//
//  Created by 向云飞 on 2016/10/22.
//  Copyright © 2016年 向云飞. All rights reserved.
//

#import "CountDownInCellViewController.h"
#import "CountDown.h"

@interface CountDownInCellViewController ()<UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *array;

@property (nonatomic, strong) CountDown *countDown;

@end

@implementation CountDownInCellViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.countDown = [[CountDown alloc] init];
    __weak typeof(self) weakSelf = self;
    
    self.array = @[@"2016-10-24 22:23:49",@"2016-10-25 14:23:43",@"2016-10-26 14:10:14",@"2016-10-27 14:10:41",@"2016-10-28 14:10:46",@"2016-10-29 14:10:23",@"2016-10-30 14:10:43",@"2016-11-01 14:11:45",@"2016-11-02 14:11:22",@"2016-11-03 14:11:40",@"2016-11-04 14:11:40",@"2016-11-05 14:11:45",@"2016-11-06 14:11:45",@"2016-11-07 14:14:41",@"2016-11-11 14:23:50",@"2016-11-12 14:23:45",@"2016-11-10 14:15:42",@"2016-11-11 14:23:51",@"2016-11-12 14:28:45",@"2016-11-13 14:16:43",@"2016-11-14 14:23:52",@"2016-11-15 14:29:45",@"2016-11-16 14:17:44",@"2016-11-17 14:23:53",@"2016-11-18 14:30:45",@"2016-11-19 14:18:45",@"2016-11-20 14:23:54",@"2016-11-21 14:31:01",@"2016-11-22 14:19:30",@"2016-11-23 14:23:55",@"2016-11-24 14:32:02",@"2016-11-25 14:20:31",@"2016-11-26 14:23:56",@"2016-11-27 14:33:03",@"2016-11-28 14:21:12",@"2016-11-29 14:23:45",@"2016-11-30 14:34:04",@"2016-11-31 14:23:32",@"2016-12-01 14:23:49",@"2016-12-02 14:04:05",@"2016-12-03 14:23:05",@"2016-12-04 14:24:12",@"2016-12-05 14:14:06",@"2016-12-06 14:24:02",@"2016-12-07 14:24:10",@"2016-12-11 14:24:07",@"2016-12-12 14:25:01",@"2016-12-10 14:24:11",@"2016-12-11 14:34:11",@"2016-12-12 14:26:03",];
    
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
    [self.countDown countDownFrequency:1.0f WithPER_SECBlock:^{
        [weakSelf updateTimeInVisibleCells];
    }];
    
}

- (void)updateTimeInVisibleCells {
    NSArray  *cells = self.tableView.visibleCells; //取出屏幕可见ceLl
    for (UITableViewCell *cell in cells) {
        cell.textLabel.text = [self getNowTimeWithString:self.array[cell.tag]];
        
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *countDown = @"countDown";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:countDown];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:countDown];
    }
    cell.tag = indexPath.row;
    cell.textLabel.text = [self getNowTimeWithString:self.array[indexPath.row]];
    
    return cell;
}


- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.dataSource = self;
    }
    return _tableView;
}

-(NSString *)getNowTimeWithString:(NSString *)aTimeString{
    NSDateFormatter* formater = [[NSDateFormatter alloc] init];
    [formater setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    // 截止时间date格式
    NSDate  *expireDate = [formater dateFromString:aTimeString];
    NSDate  *nowDate = [NSDate date];
    // 当前时间字符串格式
    NSString *nowDateStr = [formater stringFromDate:nowDate];
    // 当前时间date格式
    nowDate = [formater dateFromString:nowDateStr];
    
    NSTimeInterval timeInterval =[expireDate timeIntervalSinceDate:nowDate];
    
    int days = (int)(timeInterval/(3600*24));
    int hours = (int)((timeInterval-days*24*3600)/3600);
    int minutes = (int)(timeInterval-days*24*3600-hours*3600)/60;
    int seconds = timeInterval-days*24*3600-hours*3600-minutes*60;
    
    NSString *dayStr;NSString *hoursStr;NSString *minutesStr;NSString *secondsStr;
    //天
    dayStr = [NSString stringWithFormat:@"%d",days];
    //小时
    hoursStr = [NSString stringWithFormat:@"%d",hours];
    //分钟
    if(minutes<10)
        minutesStr = [NSString stringWithFormat:@"0%d",minutes];
    else
        minutesStr = [NSString stringWithFormat:@"%d",minutes];
    //秒
    if(seconds < 10)
        secondsStr = [NSString stringWithFormat:@"0%d", seconds];
    else
        secondsStr = [NSString stringWithFormat:@"%d",seconds];
    if (hours<=0&&minutes<=0&&seconds<=0) {
        return @"活动已经结束！";
    }
    if (days) {
        return [NSString stringWithFormat:@"%@天 %@小时 %@分 %@秒", dayStr,hoursStr, minutesStr,secondsStr];
    }
    return [NSString stringWithFormat:@"%@小时 %@分 %@秒",hoursStr , minutesStr,secondsStr];
}


@end
