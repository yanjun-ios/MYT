//
//  MyteamViewController.h
//  MYT
//
//  Created by YUNRUIMAC on 15/12/11.
//  Copyright © 2015年 YunRui. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyteamViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableview1;//主tableview
@property (weak, nonatomic) IBOutlet UITableView *tableview2;//月份1
@property (weak, nonatomic) IBOutlet UITableView *tableview3;//月份2
@property (weak, nonatomic) IBOutlet UITableView *tableview4;//年
- (IBAction)monthclickone:(id)sender;
- (IBAction)monthclicktwo:(id)sender;
- (IBAction)yearclick:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *monthone;
@property (weak, nonatomic) IBOutlet UIButton *monthtwo;
@property (weak, nonatomic) IBOutlet UIButton *year;

@property (weak, nonatomic) IBOutlet UIButton *Nabarbutton;

@end
