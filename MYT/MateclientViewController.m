//
//  MateclientViewController.m
//  MYT
//
//  Created by YUNRUIMAC on 15/12/9.
//  Copyright © 2015年 YunRui. All rights reserved.
//

#import "MateclientViewController.h"
#import "ButtomView.h"
@interface MateclientViewController ()

@end

@implementation MateclientViewController

- (void)viewDidLoad {
    
    _tableview.delegate=self;
    _tableview.dataSource=self;
    // Do any additional setup after loading the view.
    self.navigationController.navigationBarHidden=NO;
    self.navigationItem.leftItemsSupplementBackButton=NO;
    self.extendedLayoutIncludesOpaqueBars = NO;
    self.edgesForExtendedLayout = UIRectEdgeBottom | UIRectEdgeLeft | UIRectEdgeRight;
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
        UITableViewCell *cell=[_tableview dequeueReusableCellWithIdentifier:@"cell3"];
        if(!cell)
        {
            cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell3"];
            //设置产品种类
            UILabel* productType=[[UILabel alloc]initWithFrame:CGRectMake(20, 12, 150, 20)];
            productType.font=[UIFont systemFontOfSize:14];
            productType.textColor=[UIColor darkGrayColor];
            productType.tag=1000;
            productType.textAlignment=NSTextAlignmentLeft;
            [cell.contentView addSubview:productType];
            
            //设置产品匹配数
            UILabel* mateNum=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 150, 20)];
            mateNum.center=CGPointMake(ScreenWidth/2, 22);
            mateNum.font=[UIFont systemFontOfSize:14];
            mateNum.textColor=[UIColor darkGrayColor];
            mateNum.tag=1001;
            mateNum.textAlignment=NSTextAlignmentCenter;
            [cell.contentView addSubview:mateNum];
            
            //设置未跟进数
            UILabel* NotFollow=[[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth-170, 12, 150, 20)];
            NotFollow.font=[UIFont systemFontOfSize:14];
            NotFollow.textColor=[UIColor darkGrayColor];
            NotFollow.tag=1002;
            NotFollow.textAlignment=NSTextAlignmentRight;
            [cell.contentView addSubview:NotFollow];
        }
        ((UILabel*)[cell.contentView viewWithTag:1000]).text=[NSString stringWithFormat:@"产品种类 20"];
        ((UILabel*)[cell.contentView viewWithTag:1001]).text=[NSString stringWithFormat:@"匹配数 20"];
        ((UILabel*)[cell.contentView viewWithTag:1002]).text=[NSString stringWithFormat:@"未跟进数 20"];
        return cell;
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
