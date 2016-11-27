//
//  ActionSheetCell.m
//  ProjectBase
//
//  Created by 向云飞 on 16/9/6.
//  Copyright © 2016年 向云飞. All rights reserved.
//

#import "ActionSheetCell.h"

@interface ActionSheetCell ()

@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation ActionSheetCell

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *action = @"action";
    ActionSheetCell *cell = [tableView dequeueReusableCellWithIdentifier:action];
    if (!cell) {
        cell = [[ActionSheetCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:action];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self addViews];
        [self settingAutoLayout];
    }
    return self;
}

- (void)setTitleText:(NSString *)titleText {
    self.titleLabel.text = titleText;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:14.0f];
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.numberOfLines = 1;
    }
    return _titleLabel;
}

- (void)addViews {
    [self.contentView addSubview:self.titleLabel];
}

- (void)settingAutoLayout {
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.contentView);
    }];
}

@end
