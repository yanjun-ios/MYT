//
//  Z_NetRequestManager.m
//  MYT
//
//  Created by 熊凯 on 16/1/9.
//  Copyright © 2016年 YunRui. All rights reserved.
//

#import "Z_NetRequestManager.h"
#import "UIViewController+Helper.h"
static Z_NetRequestManager * sharedInstance = nil;
@implementation Z_NetRequestManager
+ (Z_NetRequestManager *)sharedInstance{
    if (sharedInstance == nil) {
        sharedInstance = [[Z_NetRequestManager alloc] init];
    }
    return sharedInstance;
}

-(NSDictionary*)getClientList:(NSDictionary*) paraDic
{
    __block NSDictionary* dic;
    
    [[QQRequestManager sharedRequestManager] GET:[SEVER_URL stringByAppendingString:@"yd/getAppUserList.action"] parameters:paraDic showHUD:YES success:^(NSURLSessionDataTask *task, id responseObject) {
        
        dic=(NSDictionary*)responseObject;
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [self.superclass qq_performSVHUDBlock:^{
            [SVProgressHUD showErrorWithStatus:@"数据请求错误！"];
        }];
       
    }];
    
    return dic;
}
@end
