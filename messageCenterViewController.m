//
//  messageCenterViewController.m
//  MYT
//
//  Created by 熊凯 on 15/12/11.
//  Copyright © 2015年 YunRui. All rights reserved.
//

#import "messageCenterViewController.h"
#import "ButtomView.h"
#import "Utility.h"
@interface messageCenterViewController ()

@end

@implementation messageCenterViewController

- (void)viewDidLoad {
    //消除多余空白行
    _tableView.delegate=self;
    _tableView.dataSource=self;
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    [_tableView  setTableFooterView:view];
    _tableView.backgroundColor=[UIColor groupTableViewBackgroundColor];
    //添加底部菜单栏
    ButtomView* BtmV=[[ButtomView alloc]initWithFrame:CGRectMake(0,ScreenHeight-50, ScreenWidth, 50)];
    [self.view addSubview:BtmV];
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

//设置分割线
-(void)viewDidLayoutSubviews
{
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset:UIEdgeInsetsMake(0,0,0,0)];
    }
    
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.tableView setLayoutMargins:UIEdgeInsetsMake(0,0,0,0)];
    }
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString* identif=@"cell";
    
    UITableViewCell* cell=[self.tableView dequeueReusableCellWithIdentifier:identif];
    if(cell==nil)
    {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identif];
    }
    switch (indexPath.row) {
        case 0:
            cell.imageView.image=[UIImage imageNamed:@"incomNoti"];
            cell.textLabel.text=@"放假通知";
            cell.detailTextLabel.text=@"【公司通知】放假20天";
            break;
        case 1:
            cell.imageView.image=[UIImage imageNamed:@"messNoti"];
            cell.textLabel.text=@"入库提醒";
            cell.detailTextLabel.text=@"【入库提醒】放假20天";
            break;
        case 2:
            cell.imageView.image=[UIImage imageNamed:@"Noti"];
            cell.textLabel.text=@"通知公告";
            cell.detailTextLabel.text=@"【公司通知】由于公司业绩不错，特组织旅游";
            break;
            
        default:
            break;
    }
    cell.detailTextLabel.textColor=[UIColor darkGrayColor];
    
    //初始化时间标签
        UILabel* lab_time=[[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth-50, 8, 50, 20)];
        lab_time.font=[UIFont systemFontOfSize:12];
        lab_time.textColor=[UIColor lightGrayColor];
    lab_time.text=@"10.19";
    
    //初始化红点
    UIView* point =[[UIView alloc]initWithFrame:CGRectMake(ScreenWidth-42, 28, 8, 8)];
    [[Utility sharedInstance] setLayerView:point borderW:0 borderColor:[UIColor clearColor] radius:4];
    point.backgroundColor=[UIColor redColor];
    
    [cell.contentView addSubview:point];
    [cell.contentView addSubview:lab_time];
    cell.selectedBackgroundView=[[UIView alloc]initWithFrame:cell.frame];
    cell.selectedBackgroundView.backgroundColor=[UIColor clearColor];
    return cell;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
