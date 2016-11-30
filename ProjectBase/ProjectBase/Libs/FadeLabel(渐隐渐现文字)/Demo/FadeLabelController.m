//
//  FadeLabelController.m
//  ProjectBase
//
//  Created by 向云飞 on 2016/10/23.
//  Copyright © 2016年 向云飞. All rights reserved.
//

#import "FadeLabelController.h"
#import "FadeLabel.h"

@interface FadeLabelController ()

@property (nonatomic, strong) FadeLabel *fadeLabel;

// 图片文字
@property (nonatomic,strong) UILabel *imageLab;

@end

@implementation FadeLabelController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.fadeLabel];
    [self.fadeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_equalTo(self.view).with.offset(50);
        make.right.mas_equalTo(self.view).with.offset(-50);
    }];
    
    self.fadeLabel.text = @"渐隐渐现Label渐隐渐现Label渐隐渐现Label渐隐渐现Label渐隐渐现Label渐隐渐现Label";
    [self.fadeLabel sizeToFit];
    
    [self.fadeLabel fadeWithComplete:^{
        DBLog(@"显示完毕");
    }];
    
    [self.view addSubview:self.imageLab];
    [self.imageLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.fadeLabel.mas_bottom).offset(kScaleFrom_iPhone6_Desgin(20));
        make.left.mas_equalTo(self.fadeLabel);
        make.right.mas_equalTo(self.fadeLabel);
    }];

}

- (FadeLabel *)fadeLabel {
    if (!_fadeLabel) {
        _fadeLabel = [[FadeLabel alloc] init];
        _fadeLabel.font = [UIFont fontWithSize:24.0f];
        _fadeLabel.textColor = [UIColor blueColor];
        _fadeLabel.numberOfLines = 0;
    }
    return _fadeLabel;
}

- (UILabel *)imageLab {
    if (!_imageLab) {
        NSString *string = @"EvestormEvestormEv";
        _imageLab = [[UILabel alloc] init];
        _imageLab.text = string;
        _imageLab.attributedText = [NSString getAttributeFromText:string imageName:@"b27_icon_star_red" imageRect:CGRectMake(0, 0, 5, 5) imageInFront:YES];
        _imageLab.numberOfLines = 0;
    }
    return _imageLab;
}

//- (void)viewWillLayoutSubviews {
//    self.fadeLabel.frame = CGRectMake(16, 16, self.view.frame.size.width - 32, self.view.frame.size.height - 32 - 20);
//}



@end
