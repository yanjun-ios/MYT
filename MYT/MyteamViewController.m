//
//  MyteamViewController.m
//  MYT
//
//  Created by YUNRUIMAC on 15/12/11.
//  Copyright © 2015年 YunRui. All rights reserved.
//

#import "MyteamViewController.h"
#import "ButtomView.h"
#import "Utility.h"
#import "KxMenu.h"
@interface MyteamViewController ()
{
    Boolean mo,mt,yr;//判断是否点开
}

@end

@implementation MyteamViewController

- (void)viewDidLoad {
    _tableview1.delegate=self;
    _tableview1.dataSource=self;
    _tableview2.delegate=self;
    _tableview2.dataSource=self;
    _tableview3.dataSource=self;
    _tableview3.delegate=self;
    _tableview4.dataSource=self;
    _tableview4.delegate=self;
    
    mo=0;//未打开
    mt=0;
    yr=0;
    _tableview2.hidden=YES;
    _tableview3.hidden=YES;
    _tableview4.hidden=YES;
    
    self.extendedLayoutIncludesOpaqueBars = NO;
    self.edgesForExtendedLayout = UIRectEdgeBottom | UIRectEdgeLeft | UIRectEdgeRight;
    self.navigationController.navigationBarHidden=NO;
    self.navigationItem.leftItemsSupplementBackButton=NO;
    [self.navigationController.navigationBar setTitleTextAttributes:
     
     @{NSFontAttributeName:[UIFont systemFontOfSize:16],
       
       NSForegroundColorAttributeName:[UIColor whiteColor]}];
    if (currentVersion <= 6.1) {
        self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    } else {
        self.navigationController.navigationBar.barTintColor = [UIColor blackColor];
        self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
        CGRect statusRe = [[UIApplication sharedApplication] statusBarFrame];
        UIView* status=[[UIView alloc]initWithFrame:CGRectMake(0, -20, statusRe.size.width, statusRe.size.height)];
        status.backgroundColor=[UIColor whiteColor];
        [self.navigationController.navigationBar addSubview:status];
    }
    
    ButtomView* BtmV=[[ButtomView alloc]initWithFrame:CGRectMake(0, ScreenHeight-114, ScreenWidth, 50)];
    [self.view addSubview:BtmV];
    
    [[Utility sharedInstance] setLayerView:_monthone borderW:1 borderColor:[UIColor redColor] radius:5];
    [[Utility sharedInstance] setLayerView:_monthtwo borderW:1 borderColor:[UIColor redColor] radius:5];
    
    //navigationbar button 效果
 
    [_Nabarbutton addTarget:self action:@selector(showMenu:) forControlEvents:UIControlEventTouchUpInside];
    [super viewDidLoad];
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (void)showMenu:(UIButton *)sender
{
    NSArray *menuItems =
    @[
      
      [KxMenuItem menuItem:@"ACTION MENU"
                     image:[UIImage imageNamed:@"ok"]
                    target:nil
                    action:NULL],
      
      [KxMenuItem menuItem:@"Share this"
                     image:[UIImage imageNamed:@"ok"]
                    target:self
                    action:NULL],
      
      ];
    
    KxMenuItem *first = menuItems[0];
    first.foreColor = [UIColor colorWithRed:47/255.0f green:112/255.0f blue:225/255.0f alpha:1.0];
    first.alignment = NSTextAlignmentCenter;
    
    [KxMenu showMenuInView:self.view
                  fromRect:sender.frame
                 menuItems:menuItems];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if([tableView isEqual:_tableview1])
    {
        return 10;    }//团队成员个数
    else if([tableView isEqual:_tableview2])
    {
        return 12;
    }
    else if([tableView isEqual:_tableview3])
    {
        return 12;
    }
    else
        return 5;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([tableView isEqual:_tableview1]) {
        UITableViewCell *cell4=[_tableview1 dequeueReusableCellWithIdentifier:@"cell"];
        return cell4;
    }
   else if([tableView isEqual:_tableview2])
    {
        UITableViewCell *cell1=[_tableview2 dequeueReusableCellWithIdentifier:@"monthcell1"];
        ((UILabel*)[cell1.contentView viewWithTag:103]).text=[NSString stringWithFormat:@"%d月",indexPath.row+1];
        return cell1;
    }
    else if([tableView isEqual:_tableview3])
    {
        UITableViewCell *cell2=[_tableview3 dequeueReusableCellWithIdentifier:@"monthcell2"];
        ((UILabel*)[cell2.contentView viewWithTag:102]).text=[NSString stringWithFormat:@"%d月",indexPath.row+1];
        return cell2;
    }
    else
    {
        UITableViewCell *cell3=[_tableview4 dequeueReusableCellWithIdentifier:@"yearcell"];
        ((UILabel*)[cell3.contentView viewWithTag:101]).text=[NSString stringWithFormat:@"%d",indexPath.row+2015];
        return cell3;
    }

}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if([tableView isEqual:_tableview1])
    {
        return 1;    }//团队成员个数
    else if([tableView isEqual:_tableview2])
    {
        return 1;
    }
    else if([tableView isEqual:_tableview3])
    {
        return 1;
    }
    else
        return 1;

}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)monthclickone:(id)sender {
    if (!mo) {
        _tableview2.hidden=NO;
        [_tableview2 reloadData];
        mo=1;
    }
    else
    {
        _tableview2.hidden=YES;
        mo=0;
    }
}

- (IBAction)monthclicktwo:(id)sender {
    if (!mt) {
        _tableview3.hidden=NO;
         [_tableview3 reloadData];
        mt=1;
    }
    else
    {
        _tableview3.hidden=YES;
        mt=0;
    }
}

- (IBAction)yearclick:(id)sender {
    if (!yr) {
        _tableview4.hidden=NO;
         [_tableview4 reloadData];
        yr=1;
    }
    else
    {
        _tableview4.hidden=YES;
        yr=0;
    }
}
@end
