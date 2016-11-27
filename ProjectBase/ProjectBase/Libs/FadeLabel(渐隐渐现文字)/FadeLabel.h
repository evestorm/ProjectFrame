//
//  FadeLabel.h
//  ProjectBase
//
//  Created by 向云飞 on 2016/10/23.
//  Copyright © 2016年 向云飞. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FadeLabel : UILabel

//淡入文字动画持续时间 默认2s
@property (nonatomic, assign) CFTimeInterval shineDuration;

//淡出文字动画持续时间 默认2s
@property (nonatomic, assign) CFTimeInterval fadeOutDuration;

//自动播放动画 默认为NO
@property (nonatomic, assign) BOOL autoStart;

//检查动画是否结束
@property (nonatomic, assign) BOOL shining;

//检查是否可见
@property (nonatomic, assign) BOOL visible;


- (void)fade;
- (void)fadeWithComplete:(void(^)())completion;
- (void)fadeOut;
- (void)fadeOutWithComplete:(void(^)())completion;

@end
