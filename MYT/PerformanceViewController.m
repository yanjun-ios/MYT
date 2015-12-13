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
{
    /*UILabel* rank;
    UILabel* name;
    UILabel* mony;*/
}
@end

@implementation PerformanceViewController

-(void)viewWillAppear:(BOOL)animated
{
    [[Utility sharedInstance] setLayerView:_topView borderW:2 borderColor:[UIColor redColor] radius:5];
    self.navigationController.navigationBarHidden=NO;
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
    static NSString* identif=@"cell";
    
    UITableViewCell* cell=[_tableview dequeueReusableCellWithIdentifier:identif];
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identif];
        //排名
        UILabel* rank;
        rank=[[UILabel alloc]initWithFrame:CGRectMake(0, 15, 100, 15)];
        rank.tag=10;
        rank.textColor=[UIColor darkGrayColor];
        rank.font=[UIFont systemFontOfSize:14];
        rank.textAlignment=NSTextAlignmentCenter;
        [cell.contentView addSubview:rank];
        //姓名
        UILabel* name;
        name=[[UILabel alloc]initWithFrame:CGRectMake(0, 15, 100, 15)];
        name.center=cell.center;
        name.tag=11;
        name.textColor=[UIColor darkGrayColor];
        name.font=[UIFont systemFontOfSize:14];
        name.textAlignment=NSTextAlignmentCenter;
        [cell.contentView addSubview:name];
        //业绩
        UILabel* mony;
        mony=[[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth-100, 15, 100, 15)];
        mony.tag=12;
        mony.textColor=[UIColor darkGrayColor];
        mony.font=[UIFont systemFontOfSize:14];
        mony.textAlignment=NSTextAlignmentCenter;
        [cell.contentView addSubview:mony];
    }
    
    UILabel* label1=(UILabel*)[cell.contentView viewWithTag:10];
    label1.text=@"第一名";
    UILabel* label2=(UILabel*)[cell.contentView viewWithTag:11];
    label2.text=@"张三";
    UILabel* label3=(UILabel*)[cell.contentView viewWithTag:12];
    label3.text=@"500万";
    
   

    

    
    
    
    
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
