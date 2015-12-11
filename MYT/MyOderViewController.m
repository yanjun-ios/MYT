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
@interface MyOderViewController ()

@end

@implementation MyOderViewController

- (void)viewDidLoad {
    _mytableview.delegate=self;
    _mytableview.dataSource=self;
    ButtomView* BtmV=[[ButtomView alloc]initWithFrame:CGRectMake(0, ScreenHeight-50, ScreenWidth, 50)];
    [self.view addSubview:BtmV];
    [super viewDidLoad];
    [_mytableview reloadData];
    // Do any additional setup after loading the view.
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
    ((UILabel*)[cell.contentView viewWithTag:101]).text=@"严军";
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
