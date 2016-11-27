//
//  BaseViewModel.m
//  ProjectBase
//
//  Created by 向云飞 on 2016/10/17.
//  Copyright © 2016年 向云飞. All rights reserved.
//

#import "BaseViewModel.h"
#import "checkNetwork.h"

static NSString *failureTip = @"网络又调皮了,请稍后重试";

@implementation BaseViewModel

+ (void)failure:(failure)failure tip:(NSString *)tip {
    NETWORK_TYPE network = [checkNetwork getNetworkTypeFromStatusBar];
    if (network == NETWORK_TYPE_NONE) {
        failure(failureTip);
    }else {
        failure(tip);
    }
}

@end
