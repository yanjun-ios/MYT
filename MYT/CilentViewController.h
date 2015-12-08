//
//  CilentViewController.h
//  MYT
//
//  Created by 熊凯 on 15/12/8.
//  Copyright © 2015年 YunRui. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CilentViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableview;
- (IBAction)rowBackClick:(id)sender;
- (IBAction)rightMenuClick:(id)sender;
- (IBAction)addClientClick:(id)sender;
- (IBAction)locationClick:(id)sender;
@end
