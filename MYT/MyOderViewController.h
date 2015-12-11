//
//  MyOderViewController.h
//  MYT
//
//  Created by 熊凯 on 15/12/11.
//  Copyright © 2015年 YunRui. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyOderViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *mytableview;
@end
