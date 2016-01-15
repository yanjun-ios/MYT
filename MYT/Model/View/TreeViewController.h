//
//  TreeViewController.h
//  MYT
//
//  Created by yunruiinfo on 16/1/15.
//  Copyright © 2016年 YunRui. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TreeViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(nonatomic,assign)NSArray *nodearr;
@end
