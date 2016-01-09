//
//  NetRequestManager.m
//  MYT
//
//  Created by 熊凯 on 16/1/9.
//  Copyright © 2016年 YunRui. All rights reserved.
//

#import "NetRequestManager.h"
static NetRequestManager * sharedInstance = nil;
@implementation NetRequestManager
+ (NetRequestManager *)sharedInstance{
    if (sharedInstance == nil) {
        sharedInstance = [[NetRequestManager alloc] init];
    }
    return sharedInstance;
}
@end
