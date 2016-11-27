//
//  ProcessFilter.m
//  Network
//
//  Created by MyMac on 16/1/5.
//  Copyright © 2016年 MyMac. All rights reserved.
//

#import "ProcessFilter.h"
#import "BaseRequest.h"

@implementation ProcessFilter

- (NSMutableDictionary *)processArgumentWithRequest:(NSMutableDictionary *)argument{
    
    //应用版本
    
    UIDevice *currentDevice = [UIDevice currentDevice];
    
    //系统类型
    argument[@"system"] = @"iOS";
    //系统版本号
    argument[@"system_version"] = [NSString stringWithFormat:@"%@",currentDevice.systemVersion];
    //应用名称
    argument[@"app_name"] = @"daiyanxiu";
    //应用版本
    argument[@"app_version"] = [NSString stringWithFormat:@"%@",[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]];
    //应用平台
    argument[@"platform"] = @"iPhone";
    
    //客户端时间，时间戳，单位秒
    NSTimeInterval currentTime = [[NSDate date] timeIntervalSince1970];
    argument[@"datetime"] = [NSString stringWithFormat:@"%.0f",currentTime];
    //设备名称
//    argument[@"device_name"] = [NSString deviceType];
    //设备唯一标识UUID
    argument[@"device_id"] = currentDevice.identifierForVendor.UUIDString;
    //设备分辨率
    argument[@"resolution"] = [NSString stringWithFormat:@"%.0f*%.0f",kScreen_Width,kScreen_Height];
    
    return argument;
}

- (id) processResponseWithRequest:(id)response{
    return nil;
}

@end
