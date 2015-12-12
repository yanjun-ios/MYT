//
//  PerformanceViewController.m
//  MYT
//
//  Created by 熊凯 on 15/12/12.
//  Copyright © 2015年 YunRui. All rights reserved.
//

#import "PerformanceViewController.h"
#import "Utility.h"
@interface PerformanceViewController ()

@end

@implementation PerformanceViewController

-(void)viewWillAppear:(BOOL)animated
{
    [[Utility sharedInstance] setLayerView:_topView borderW:2 borderColor:[UIColor redColor] radius:5];
}

- (void)viewDidLoad {
    _tableview.delegate=self;
    _tableview.dataSource=self;
        [super viewDidLoad];
    // Do any additional setup after loading the view.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - tableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 10;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString* identif=@"cell";
    //排名
    UITableViewCell* cell=[_tableview dequeueReusableCellWithIdentifier:identif];
    UILabel* rank=[[UILabel alloc]initWithFrame:CGRectMake(0, 15, 100, 15)];
    rank.textColor=[UIColor darkGrayColor];
    rank.font=[UIFont systemFontOfSize:14];
    rank.text=@"第一名";
    rank.textAlignment=NSTextAlignmentCenter;
    
    //姓名
    UILabel* name=[[UILabel alloc]initWithFrame:CGRectMake(0, 15, 100, 15)];
    name.center=cell.center;
    name.textColor=[UIColor darkGrayColor];
    name.font=[UIFont systemFontOfSize:14];
    name.text=@"张三";
    name.textAlignment=NSTextAlignmentCenter;
    
    //业绩
    UILabel* mony=[[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth-100, 15, 100, 15)];
    mony.textColor=[UIColor darkGrayColor];
    mony.font=[UIFont systemFontOfSize:14];
    mony.text=@"28万元";
    mony.textAlignment=NSTextAlignmentCenter;
    
    [cell addSubview:rank];
    [cell addSubview:name];
    [cell addSubview:mony];
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)btnFirstClick:(id)sender {
    _btnFirst.backgroundColor=[UIColor redColor];
    [_btnFirst setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    _btnSecond.backgroundColor=[UIColor clearColor];
    [_btnSecond setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
}

- (IBAction)btnSecondClick:(id)sender {
    
    _btnSecond.backgroundColor=[UIColor redColor];
    [_btnSecond setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    _btnFirst.backgroundColor=[UIColor clearColor];
    [_btnFirst setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
}
@end
