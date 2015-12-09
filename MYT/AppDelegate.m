//
//  AppDelegate.m
//  MYT
//
//  Created by Qingqing on 15/12/7.
//  Copyright (c) 2015年 YunRui. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [self qq_demo];
    return YES;
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

/**
 *  网络请求、图片异步加载、HUD提示，Demo演示
 */
-(void)qq_demo{

    /**
     *  网络加载Demo
     *  showHUD:表示加载时是否显示加载提示
     */
    NSString* url = @"http://api.hxzxg.com/mint/banner/list";
    NSDictionary* paraDic = @{@"city_id":@(310100)};
    [[QQRequestManager sharedRequestManager] GET:url parameters:paraDic showHUD:NO success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"%@",responseObject);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
    
    /**
     *  图片异步加载（包括按钮上的）
     */
    [[UIButton new] qq_setButtonImageWithURL:[NSURL URLWithString:@"http://www.####.jpg"] placeholderImage:[UIImage imageNamed:@"#填写本地图片路径，用于图片还没加载完成之前显示#"]];
    [[UIImageView new] qq_setImageWithURL:[NSURL URLWithString:@"http://www.####.jpg"] placeholderImage:[UIImage imageNamed:@"#填写本地图片路径，用于图片还没加载完成之前显示#"]];
    
    /**
     *  提示功能
     */
    [SVProgressHUD showSuccessWithStatus:@"登录成功"];
    [SVProgressHUD showErrorWithStatus:@"登录失败"];
    [SVProgressHUD showWithStatus:@"正在加载中"];//带菊花的提示
}

@end
