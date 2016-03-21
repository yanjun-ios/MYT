//
//  ChooseNeedsViewController.m
//  MYT
//
//  Created by 熊凯 on 16/3/17.
//  Copyright © 2016年 YunRui. All rights reserved.
//

#import "ChooseNeedsViewController.h"
#import "QQRequestManager.h"
#import "MJRefresh.h"
#import "TheMenuViewController.h"
#import "IIViewDeckController.h"
#import "NetRequestManager.h"
@interface ChooseNeedsViewController ()
{
    __block NSMutableArray* getNeedsAry;
    int pageNum;
    
    NSMutableArray* chooseAry;
}

@end

@implementation ChooseNeedsViewController

- (void)viewDidLoad {
    chooseAry=[[NSMutableArray alloc]init];
    pageNum=0;
    _tableview.delegate=self;
    _tableview.dataSource=self;
    _searchNeedsBar.delegate=self;
    getNeedsAry=[[NSMutableArray alloc]init];
     _tableview.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadData)];
    //消除多余空白行
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    [_tableview setTableFooterView:view];
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


//搜所代理方法
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    
    [getNeedsAry removeAllObjects];
    pageNum=0;
    [self loadData];
}

///获取数据
-(void)loadData
{
    pageNum++;
    NSMutableDictionary* parDic=[[NSMutableDictionary alloc]init];
    [parDic setValue:[NSString stringWithFormat:@"%d",pageNum] forKey:@"pageNum"];
    [parDic setValue:@10 forKey:@"pageSize"];
    [parDic setValue:_searchNeedsBar.text forKey:@"name"];
    [[QQRequestManager sharedRequestManager] GET:[SEVER_URL stringByAppendingString:@"yd/getMatReqAddItem.action"] parameters:parDic showHUD:YES success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSArray* jsonAry=(NSArray*)[responseObject objectForKey:@"list"];
        for (NSDictionary* dic in jsonAry) {
            NSMutableDictionary* mdic=[[NSMutableDictionary alloc]initWithDictionary:dic];
            [mdic setValue:@0 forKey:@"btnState"];
            [getNeedsAry addObject:mdic];
        }
        //[getNeedsAry addObjectsFromArray:[responseObject objectForKey:@"list"]];
        [_tableview reloadData];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
    
    [_tableview.mj_footer endRefreshing];
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 定义cell标识  每个cell对应一个自己的标识
   // NSString *CellIdentifier = [NSString stringWithFormat:@"cell%ld%ld",indexPath.section,indexPath.row];
    NSString *CellIdentifier=@"cellidentifi";
    // 通过不同标识创建cell实例
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        //名称
        UILabel* name;
        name=[[UILabel alloc]initWithFrame:CGRectMake(10, 15, ScreenWidth/2, 40)];
        name.tag=100;
        name.textColor=[UIColor lightGrayColor];
        name.font=[UIFont systemFontOfSize:12];
        name.textAlignment=NSTextAlignmentLeft;
        [cell.contentView addSubview:name];
        
        //添加
        
        UIButton* btn=[[UIButton alloc]initWithFrame:CGRectMake(ScreenWidth-50, 20, 30, 30)];
        btn.tag=101;
        [btn addTarget:self action:@selector(addNeeds:) forControlEvents:UIControlEventTouchUpInside];
        [cell.contentView addSubview:btn];
        
  }
    
    
    UILabel* label1=(UILabel*)[cell.contentView viewWithTag:100];
    label1.lineBreakMode = NSLineBreakByWordWrapping;
    label1.numberOfLines = 0;
    label1.text=[[getNeedsAry objectAtIndex:[indexPath row]] objectForKey:@"NAME"];
    
    //根据数据源初始化按钮
    UIButton* btn=(UIButton*)[cell.contentView viewWithTag:101];
    int state = ((NSNumber*)[[getNeedsAry objectAtIndex:[indexPath row]] objectForKey:@"btnState"]).intValue;
    if (state==0) {
        [btn setImage:[UIImage imageNamed:@"addNeeds1"] forState:UIControlStateNormal];
        btn.selected=NO;
    }else
    {
        [btn setImage:[UIImage imageNamed:@"addNeeds2"] forState:UIControlStateNormal];
         btn.selected=YES;
    }
    
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [getNeedsAry count];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}

-(void)addNeeds:(UIButton*)sender
{
//     _constraint_top.constant=-44;
//    [self.view setNeedsUpdateConstraints];
//    [UIView animateWithDuration:0.3f animations:^{
//        [self.view layoutIfNeeded];
//    }];
        UITableViewCell* cell = (UITableViewCell*)[[sender superview] superview];
    NSIndexPath* index=[_tableview indexPathForCell:cell];
    NSString* ID=[[getNeedsAry objectAtIndex:index.row] objectForKey:@"ID"];
    NSString* TW=[[getNeedsAry objectAtIndex:index.row] objectForKey:@"TW"];
    NSDictionary* dic=[[NSDictionary alloc]initWithObjectsAndKeys:ID,@"ID",TW,@"TW", nil];
    if (sender.selected) {
        
        [sender setImage:[UIImage imageNamed:@"addNeeds1"] forState:UIControlStateNormal];
        sender.selected=NO;
        if ([chooseAry containsObject:dic]) {
            [chooseAry removeObject:dic];
        }
        [[getNeedsAry objectAtIndex:index.row] setValue:@0 forKey:@"btnState"];
    }else
    {
        [sender setImage:[UIImage imageNamed:@"addNeeds2"] forState:UIControlStateNormal];
        sender.selected=YES;
        
        if (![chooseAry containsObject:dic]) {
            [chooseAry addObject:dic];
        }
        [[getNeedsAry objectAtIndex:index.row] setValue:@1 forKey:@"btnState"];
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

- (IBAction)finishedChoosed:(id)sender {
   NSString* message =  [NSString stringWithFormat:@"您已选择%lu种物料",(unsigned long)chooseAry.count];
    UIAlertView* alert=[[UIAlertView alloc]initWithTitle:@"提示" message:message delegate:self cancelButtonTitle:@"返回" otherButtonTitles:@"确定", nil];
    [alert show];
    
   
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==1) {
        TheMenuViewController* MenuContro=(TheMenuViewController*)self.viewDeckController.rightController;
        self.passneesdelegat=MenuContro;
        //self.LocationDelegate=contro;
        [self.passneesdelegat passNeeds:chooseAry];
        [self.navigationController popViewControllerAnimated:YES];
        [NetRequestManager sharedInstance].FROMDECK=1;
    }
}

@end
