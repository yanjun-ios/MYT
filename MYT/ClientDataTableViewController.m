//
//  ClientDataTableViewController.m
//  MYT
//
//  Created by 熊凯 on 15/12/9.
//  Copyright © 2015年 YunRui. All rights reserved.
//

#import "ClientDataTableViewController.h"

@interface ClientDataTableViewController ()

@end

@implementation ClientDataTableViewController

- (void)viewDidLoad {
 if(currentVersion>=7)
 {
     self.edgesForExtendedLayout = UIRectEdgeNone;    
 }
    
    //设置背景颜色
    self.tableView.backgroundColor=[UIColor groupTableViewBackgroundColor];
        [super viewDidLoad];
    }

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
