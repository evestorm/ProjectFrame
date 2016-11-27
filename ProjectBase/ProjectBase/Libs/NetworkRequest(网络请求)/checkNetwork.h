//
//  checkNetwork.h
//  Daiyanxiu
//
//  Created by 向云飞 on 16/6/28.
//  Copyright © 2016年 MyMac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger , NETWORK_TYPE) {
    NETWORK_TYPE_NONE= 0,
    NETWORK_TYPE_2G= 1,
    NETWORK_TYPE_3G= 2,
    NETWORK_TYPE_4G= 3,
    NETWORK_TYPE_5G= 4,//  5G目前为猜测结果
    NETWORK_TYPE_WIFI= 5,
};


@interface checkNetwork : NSObject

+ (NETWORK_TYPE)getNetworkTypeFromStatusBar;

@end
