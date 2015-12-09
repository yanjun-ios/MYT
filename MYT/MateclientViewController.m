//
//  MateclientViewController.m
//  MYT
//
//  Created by YUNRUIMAC on 15/12/9.
//  Copyright © 2015年 YunRui. All rights reserved.
//

#import "MateclientViewController.h"

@interface MateclientViewController ()

@end

@implementation MateclientViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _tableview.delegate=self;
    _tableview.dataSource=self;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return  10;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
        UITableViewCell *cell1=[_tableview dequeueReusableCellWithIdentifier:@"cell1"];
        return cell1;
    }
    else
    {
        UITableViewCell* cell2=[_tableview dequeueReusableCellWithIdentifier:@"cell2"];
        return cell2;
    }

}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view =[[UIView alloc]initWithFrame:CGRectMake(0,0, _tableview.frame.size.width, 25)];
    UILabel *remindtime=[[UILabel alloc]initWithFrame:CGRectMake(0, 5, _tableview.frame.size.width,20)];
    remindtime.text=@"2015年8月14日入库";
    remindtime.font=[UIFont fontWithName:@"ArialMT" size:14];
    remindtime.textAlignment=NSTextAlignmentCenter;
    remindtime.textColor=[UIColor orangeColor];//入库时间
    
    [view addSubview:remindtime];
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{return  26;}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
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

@end
