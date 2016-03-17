//
//  ChooseNeedsViewController.h
//  MYT
//
//  Created by 熊凯 on 16/3/17.
//  Copyright © 2016年 YunRui. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChooseNeedsViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>
@property (weak, nonatomic) IBOutlet UISearchBar *searchNeedsBar;
@property (weak, nonatomic) IBOutlet UITableView *tableview;

@end
