//
//  ClientDataTableViewController.m
//  MYT
//
//  Created by 熊凯 on 15/12/9.
//  Copyright © 2015年 YunRui. All rights reserved.
//

#import "ClientDataTableViewController.h"
#import "NetRequestManager.h"
#import "QQRequestManager.h"
@interface ClientDataTableViewController ()

@end

@implementation ClientDataTableViewController

- (void)viewDidLoad {
   _clientId= [NetRequestManager sharedInstance].clientId;
 if(currentVersion>=7)
 {
    self.edgesForExtendedLayout = UIRectEdgeNone;
 }
    
    //设置背景颜色
    self.tableView.backgroundColor=[UIColor groupTableViewBackgroundColor];
        [super viewDidLoad];
    
    [self loadData:_clientId];
}


-(void)loadData:(int)clientId
{
    NSString* cusid=[NSString stringWithFormat:@"%d",clientId];
    NSMutableDictionary* pardic=[[NSMutableDictionary alloc]initWithCapacity:10];
    [pardic setValue:[[NSUserDefaults standardUserDefaults]objectForKey:@"user_id"] forKey:@"userid"];
    [pardic setObject:cusid forKey:@"cusid"];
    [[QQRequestManager sharedRequestManager] GET:[SEVER_URL stringByAppendingString:@"yd/getCusInfo.action"] parameters:pardic showHUD:YES success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSLog(@"%@",responseObject);
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
