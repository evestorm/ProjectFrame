//
//  ActionSheetCell.h
//  ProjectBase
//
//  Created by 向云飞 on 16/9/6.
//  Copyright © 2016年 向云飞. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ActionSheetCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView;

- (void)setTitleText:(NSString *)titleText;

@end
