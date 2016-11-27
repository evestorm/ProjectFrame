//
//  AppDelegate.m
//  ProjectBase
//
//  Created by 向云飞 on 16/7/26.
//  Copyright © 2016年 向云飞. All rights reserved.
//

#import "AppDelegate.h"
#import "NavigationController.h"
#import "ViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    self.window = [[UIWindow alloc] init];
    self.window.backgroundColor = [UIColor whiteColor];
    self.window.frame = [UIScreen mainScreen].bounds;
    
    [self setupMainViewController];
    
//    if (!kUserDefault.appVersion || ![kUserDefault.appVersion isEqualToString:kVersion]) {
//        [self setupIntroductionViewController];
//    }else {
//        [self setupMainViewController];
//    }
    
    [self.window makeKeyAndVisible];
    
    
    //SDWebImage 内存优化
    [[SDImageCache sharedImageCache] setShouldDecompressImages:NO];
    [[SDWebImageDownloader sharedDownloader] setShouldDecompressImages:NO];
    
    //友盟
    [UMSocialData setAppKey:kUmengKey];
    [UMSocialQQHandler setQQWithAppId:kSocial_QQ_ID appKey:kSocial_QQ_Secret url:kSocial_QQ_Url];
    [UMSocialWechatHandler setWXAppId:kSocial_WX_ID appSecret:kSocial_WX_Secret url:kSocial_WX_Url];
    [UMSocialSinaSSOHandler openNewSinaSSOWithAppKey:kSocial_Sina_AppKey secret:kSocial_Sina_Secret RedirectURL:kSocial_Sina_RedirectURL];
    
    return YES;
}


//如果不是第一次启动 进入主界面
- (void)setupMainViewController {
    ViewController *controller = [[ViewController alloc] init];
    NavigationController *nav = [[NavigationController alloc] initWithRootViewController:controller];
    self.window.rootViewController = nav;
}

- (void)setupIntroductionViewController {
//    IntroductionViewController *introductionVC = [[IntroductionViewController alloc] init];
//    self.window.rootViewController = introductionVC;
}


- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options {
    if ([url.host isEqualToString:@"pay"]||[url.host isEqualToString:@"safepay"]||[url.host isEqualToString:@"platformapi"]) {
        [[PayAPI sharePayAPI] handleOpenUrl:url];
    }
    
    return nil;
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    if ([url.host isEqualToString:@"pay"]||[url.host isEqualToString:@"safepay"]||[url.host isEqualToString:@"platformapi"]) {
        [[PayAPI sharePayAPI] handleOpenUrl:url];
    }
    
    return nil;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

//当出现内存警告的时候
- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    [[SDImageCache sharedImageCache] cleanDisk]; //清除磁盘
    [[SDImageCache sharedImageCache] clearMemory]; //清除内存
    [[SDImageCache sharedImageCache] setMaxCacheAge:7 * 24 * 60 * 60];  //设置缓存的最大时间
}

@end
