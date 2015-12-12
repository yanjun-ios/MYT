//
//  RemindViewController.m
//  MYT
//
//  Created by YUNRUIMAC on 15/12/8.
//  Copyright © 2015年 YunRui. All rights reserved.
//

#import "RemindViewController.h"
#import "ButtomView.h"
@interface RemindViewController ()

@end

@implementation RemindViewController

- (void)viewDidLoad {
    
    _tableview.delegate=self;
    _tableview.dataSource=self;
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
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{return  25;}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{//这儿改的时候根据section integer
    UIView * view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, _tableview.frame.size.width, 25)];
    UILabel *remindtime=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, _tableview.frame.size.width,20)];
    remindtime.text=@"2015年8月14日入库";
    remindtime.font=[UIFont fontWithName:@"ArialMT" size:14];
    remindtime.textAlignment=NSTextAlignmentCenter;
    remindtime.textColor=[UIColor orangeColor];//入库时间
    
    /*UIView *kindofpro=[[UIView alloc]initWithFrame:CGRectMake(0,25, _tableview.frame.size.width, 35)];
    kindofpro.backgroundColor=[UIColor whiteColor];//产品种类等
    UITapGestureRecognizer*tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(Actiondo:)];
    [kindofpro addGestureRecognizer:tapGesture];//添加view的点击事件
    
    UILabel *countofkind=[[UILabel alloc]initWithFrame:CGRectMake(15, 5, _tableview.frame.size.width/5, 20)];
    countofkind.textColor=[UIColor grayColor];
    countofkind.text=@"产品种类";
    countofkind.font=[UIFont fontWithName:@"ArialMT" size:14];
    UILabel* count1=[[UILabel alloc]initWithFrame:CGRectMake(20+_tableview.frame.size.width/6, 5, _tableview.frame.size.width/6, 20)];
    count1.textColor=[UIColor blackColor];
    count1.text=@"20";
    count1.font=[UIFont fontWithName:@"ArialMT" size:18];
    
    UILabel *countofmatch=[[UILabel alloc]initWithFrame:CGRectMake(10+_tableview.frame.size.width/3, 5, _tableview.frame.size.width/6, 20)];
    countofmatch.textColor=[UIColor grayColor];
    countofmatch.text=@"匹配数";
    countofmatch.font=[UIFont fontWithName:@"ArialMT" size:14];
    UILabel* count2=[[UILabel alloc]initWithFrame:CGRectMake(10+_tableview.frame.size.width/2, 5, _tableview.frame.size.width/6, 20)];
    count2.textColor=[UIColor blackColor];
    count2.text=@"50";
    count2.font=[UIFont fontWithName:@"ArialMT" size:18];
    
    UILabel *unfollowed=[[UILabel alloc]initWithFrame:CGRectMake(_tableview.frame.size.width*2/3, 5, _tableview.frame.size.width/5, 20)];
    unfollowed.textColor=[UIColor grayColor];
    unfollowed.text=@"未跟进数";
    unfollowed.font=[UIFont fontWithName:@"ArialMT" size:14];
    UILabel* count3=[[UILabel alloc]initWithFrame:CGRectMake(10+_tableview.frame.size.width*5/6, 5, _tableview.frame.size.width/6, 20)];
    count3.textColor=[UIColor blackColor];
    count3.text=@"20";
    count3.font=[UIFont fontWithName:@"ArialMT" size:18];
    
    [kindofpro addSubview:count3];
    [kindofpro addSubview:unfollowed];
    [kindofpro addSubview:count2];
    [kindofpro addSubview:countofmatch];
    [kindofpro addSubview:count1];
    [kindofpro addSubview:countofkind];
    [view addSubview:kindofpro];*/
    [view addSubview:remindtime];
    return view;
}
-(void)Actiondo:(id)sender
{
    [self performSegueWithIdentifier:@"toclient" sender:self];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
        [self performSegueWithIdentifier:@"toclient" sender:self];
    }
    else
    [self performSegueWithIdentifier:@"tomate" sender:self];
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"toclient"]) {
        
    }
    else if ([segue.identifier isEqualToString:@"tomate"])
    {
        
    }
}//有数据传参数
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row==0)
    {
        UITableViewCell *cell=[_tableview dequeueReusableCellWithIdentifier:@"cell1"];

        return cell;
    }
    else
    {
        UITableViewCell *cell1=[_tableview dequeueReusableCellWithIdentifier:@"cell"];
        
        return cell1;
    }
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
