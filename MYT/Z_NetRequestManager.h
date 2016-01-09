//
//  Z_NetRequestManager.h
//  MYT
//
//  Created by 熊凯 on 16/1/9.
//  Copyright © 2016年 YunRui. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Z_NetRequestManager : NSObject
/**
 *  工具类单例
 */
+ (Z_NetRequestManager *)sharedInstance;

-(NSDictionary*)getClientList:(NSDictionary*) paraDic;
@end
