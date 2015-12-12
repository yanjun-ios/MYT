//
//  MoreViewController.m
//  MYT
//
//  Created by 熊凯 on 15/12/11.
//  Copyright © 2015年 YunRui. All rights reserved.
//

#import "MoreViewController.h"
#import "Utility.h"
@interface MoreViewController ()

@end

@implementation MoreViewController

-(void)viewWillAppear:(BOOL)animated
{
 [[Utility sharedInstance] setLayerView:_btnMore borderW:2 borderColor:[UIColor whiteColor] radius:40];
}

- (void)viewDidLoad {
    _tableview.delegate=self;
    _tableview.dataSource=self;
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    [_tableview setTableFooterView:view];
    _tableview.backgroundColor=[UIColor groupTableViewBackgroundColor];
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

#pragma mark - tableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 2;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString* identif=@"cell";
    
    UITableViewCell* cell=[_tableview dequeueReusableCellWithIdentifier:identif];
    if(cell==nil)
    {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identif];
    }
    if(indexPath.section==0&&indexPath.row==0)
    {
        cell.imageView.image=[UIImage imageNamed:@"set"];
        cell.textLabel.text=@"设置";
    }else if (indexPath.section==0&&indexPath.row==1)
    {
        cell.imageView.image=[UIImage imageNamed:@"about"];
        cell.textLabel.text=@"关于我们";
    }else if(indexPath.section==1&&indexPath.row==0)
    {
        cell.imageView.image=[UIImage imageNamed:@"checkUpdate"];
        UIImageView* imgV=[[UIImageView alloc]initWithFrame:CGRectMake(ScreenWidth-50, 0, 30, 20)];
        imgV.center=CGPointMake(imgV.center.x, cell.center.y);
        imgV.image=[UIImage imageNamed:@"new"];
        [cell.contentView addSubview:imgV];
        cell.textLabel.text=@"检查更新";
    }
    else if(indexPath.section==1&&indexPath.row==1)
    {
        cell.imageView.image=[UIImage imageNamed:@"logoff"];
        cell.textLabel.text=@"注销账号";
    }
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    cell.selectedBackgroundView=[[UIView alloc]initWithFrame:cell.frame];
    cell.selectedBackgroundView.backgroundColor=[UIColor clearColor];
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

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section==0&&indexPath.row==0)
    {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        UITableViewController *moreVC= (UITableViewController *)[storyboard instantiateViewControllerWithIdentifier:@"settinContro"];
        [self.navigationController pushViewController:moreVC animated:YES];

    }else if (indexPath.section==0&&indexPath.row==1)
    {
        [self performSegueWithIdentifier:@"aboutUs" sender:nil];
    }else if(indexPath.section==1&&indexPath.row==0)
    {
       
    }
    else if(indexPath.section==1&&indexPath.row==1)
    {
         [self.navigationController popToRootViewControllerAnimated:NO];
    }

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
