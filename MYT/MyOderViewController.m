//
//  MyOderViewController.m
//  MYT
//
//  Created by 熊凯 on 15/12/11.
//  Copyright © 2015年 YunRui. All rights reserved.
//

#import "MyOderViewController.h"
#import "MainViewController.h"
#import "ButtomView.h"
#import "MJRefresh.h"
#import "Utility.h"
#import "QuartzCore/QuartzCore.h"
@interface MyOderViewController ()
{

    NIDropDown *dropDown;
}
@end

@implementation MyOderViewController
@synthesize btn_year;
- (void)viewDidLoad {
    _mytableview.delegate=self;
    _mytableview.dataSource=self;
    [super viewDidLoad];
    //添加底部菜单栏
    ButtomView* BtmV=[[ButtomView alloc]initWithFrame:CGRectMake(0, ScreenHeight-50, ScreenWidth, 50)];
    [self.view addSubview:BtmV];
    
    //设置年月下拉按钮
    [[Utility sharedInstance]setLayerView:btn_year borderW:1 borderColor:[UIColor redColor] radius:3];
    [[Utility sharedInstance]setLayerView:_btn_FirstMonth borderW:1 borderColor:[UIColor redColor] radius:3];
    [[Utility sharedInstance]setLayerView:_btn_endMonth borderW:1 borderColor:[UIColor redColor] radius:3];
    [btn_year addTarget:self action:@selector(clickBtnYear:) forControlEvents:UIControlEventTouchUpInside];
    [_btn_FirstMonth addTarget:self action:@selector(clickBtnYear:) forControlEvents:UIControlEventTouchUpInside];
    [_btn_endMonth addTarget:self action:@selector(clickBtnYear:) forControlEvents:UIControlEventTouchUpInside];
   
}
- (void)viewDidUnload {
    //    [btnSelect release];
    btn_year = nil;
    [super viewDidUnload];
}


-(void)clickBtnYear:(UIButton*)sender
{
    NSArray * arr = [[NSArray alloc] init];
    if(sender.tag==1000)
    {
        arr = [NSArray arrayWithObjects:@"2015年", @"2016年", @"2017年", @"2018年", @"2019年", @"2020年", @"2021年", @"2022年", @"2023年", @"2024年",nil];
    }else
    {
        arr = [NSArray arrayWithObjects:@"01月", @"02月", @"03月", @"04月", @"05月", @"06月", @"07月", @"08月", @"09月", @"10月",@"11月",@"12月",nil];
    }
   
        if(dropDown == nil) {
        CGFloat f = 200;
        dropDown = [[NIDropDown alloc]showDropDown:sender :&f :arr :nil :@"down"];
        dropDown.delegate = self;
        }
    else {
        [dropDown hideDropDown:sender];
        [self rel];
    }
}

- (void) niDropDownDelegateMethod: (NIDropDown *) sender {
   
    [self rel];
}
-(void)rel{
    //    [dropDown release];
    dropDown = nil;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - tableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 6;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString* identif=@"cell";
    UITableViewCell* cell=[_mytableview dequeueReusableCellWithIdentifier:identif];
    if(indexPath.row%2==0)
    {
        ((UILabel*)[cell.contentView viewWithTag:101]).text=@"严军";
    }
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 8;
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



@end
