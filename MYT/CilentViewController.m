//
//  CilentViewController.m
//  MYT
//
//  Created by 熊凯 on 15/12/8.
//  Copyright © 2015年 YunRui. All rights reserved.
//

#import "CilentViewController.h"
#import "XNTabBarController.h"
#import"Utility.h"
@interface CilentViewController ()
{
    int  toIndex;
    NSMutableArray *data;//客户数据都在这儿
    int j;
}

@end

@implementation CilentViewController
-(void)viewDidAppear:(BOOL)animated
{
    [_tableview reloadData];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [self.viewDeckController closeRightView];
    [self.viewDeckController setPanningMode:IIViewDeckNoPanning];
}

-(void)viewWillAppear:(BOOL)animated

{
    [self.viewDeckController setPanningMode:IIViewDeckFullViewPanning];
    
    _tableview.rowHeight=UITableViewAutomaticDimension;
    _tableview.estimatedRowHeight=44.0;//这个必须加上，否则出现高度无法自适应问题。
    
    [self initinfor];
    [_tableview reloadData];
    self.navigationController.navigationBarHidden=NO;
   
    
    
}
-(void)initinfor
{ j=1;
    
    if (!data&&[[NSUserDefaults standardUserDefaults]objectForKey:@"user_id"]) {
        data = [[NSMutableArray alloc]init];
        NSMutableDictionary* parDic=[[NSMutableDictionary alloc]initWithCapacity:10];
        [parDic setValue:[[NSUserDefaults standardUserDefaults]objectForKey:@"user_id"] forKey:@"userid"];
        NSLog(@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"user_id"]);
        [parDic setValue:@"5" forKey:@"pageSize"];
        NSString *stringJ = [NSString stringWithFormat:@"%d",j];
        
        [parDic setValue:stringJ forKey:@"pageNum"];
//        NSDictionary* responseObject= [[Y_NetRequestManager sharedInstance] getClientList:parDic];
//       if(responseObject)
//        {
//            NSArray *init=[responseObject objectForKey:@"list"];
//            for (int i = 0; i<init.count; i++) {
//                [data addObject:[init objectAtIndex:i]];
//                       [_tableview reloadData];
//            }
//        }else
//        {
//            [self qq_performSVHUDBlock:^{
//               [SVProgressHUD showErrorWithStatus:@"暂时没有任何数据！"];
//            }];
//        }
        [[QQRequestManager sharedRequestManager] GET:[SEVER_URL stringByAppendingString:@"yd/getAppUserList.action"] parameters:parDic showHUD:YES success:^(NSURLSessionDataTask *task, id responseObject) {
            
            NSLog(@"%@",responseObject);
            NSArray *init=[responseObject objectForKey:@"list"];
            for (int i = 0; i<init.count; i++) {
                [data addObject:[init objectAtIndex:i]];
            }
            [_tableview reloadData];
            NSLog(@"%d",data.count);

        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            
            
            [self qq_performSVHUDBlock:^{
                [SVProgressHUD showErrorWithStatus:@"账号或密码错误"];
            }];
        }];
   }
   
   [_tableview.mj_footer beginRefreshing];
    
}
- (void)viewDidLoad {
   
    
    
    _tableview.delegate=self;
    _tableview.dataSource=self;
    _tableview.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    _tableview.mj_footer.automaticallyHidden = NO;
   
    _tableview.sectionFooterHeight=0;
    _tableview.sectionHeaderHeight=10;
    _tableview.rowHeight=UITableViewAutomaticDimension;
    _tableview.estimatedRowHeight=44.0;//这个必须加上，否则出现高度无法自适应问题。
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
}
/*- (void)example01
{
    __unsafe_unretained __typeof(self) weakSelf = self;
    
    // 设置回调（一旦进入刷新状态就会调用这个refreshingBlock）
    _tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [_tableview loadNewData];
    }];
    
    // 马上进入刷新状态
    [_tableview.mj_header beginRefreshing];
}*/


/*- (void)example01
{
    __unsafe_unretained __typeof(self) weakSelf = self;
    
    // 设置回调（一旦进入刷新状态就会调用这个refreshingBlock）
    _tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [_tableview loadNewData];
    }];
    
    // 马上进入刷新状态
    [_tableview.mj_header beginRefreshing];
}*/
/*- (void)example11
{
   // [self example01];
    
    __unsafe_unretained __typeof(self) weakSelf = self;
    
    // 设置回调（一旦进入刷新状态就会调用这个refreshingBlock）
    _tableview.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [self loadMoreData];
    }];
}*/
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    NSString *find=[_findcust.text stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
     NSMutableDictionary* parDic=[[NSMutableDictionary alloc]initWithCapacity:10];
    [parDic setValue:[[NSUserDefaults standardUserDefaults]objectForKey:@"user_id"] forKey:@"pageNum"];//user_id
    
    [[QQRequestManager sharedRequestManager] GET:[SEVER_URL stringByAppendingString:@"yd/queryCuss.action"] parameters:parDic showHUD:YES success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"%@",responseObject);
        NSArray *init=[responseObject objectForKey:@"list"];
        for (int i = 0; i<init.count; i++) {
            [data addObject:[init objectAtIndex:i]];
        }
        [_tableview reloadData];
        //NSLog(@"%d",data.count);
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        
        [self qq_performSVHUDBlock:^{
            [SVProgressHUD showErrorWithStatus:@"账号或密码错误"];
        }];
    }];
  
    
}
- (void)loadMoreData
{
    // 1.添加假数据
    j++;
    NSMutableDictionary* parDic=[[NSMutableDictionary alloc]initWithCapacity:10];
    [parDic setValue:[[NSUserDefaults standardUserDefaults]objectForKey:@"user_id"] forKey:@"userid"];
    NSLog(@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"user_id"]);
    [parDic setValue:@"5" forKey:@"pageSize"];
    NSString *stringJ = [NSString stringWithFormat:@"%d",j];
    [parDic setValue:@"1" forKey:@"pageNum"];
     [[QQRequestManager sharedRequestManager] GET:[SEVER_URL stringByAppendingString:@"yd/getAppUserList.action"] parameters:parDic showHUD:YES success:^(NSURLSessionDataTask *task, id responseObject) {        
        NSLog(@"%@",responseObject);
        NSArray *init=[responseObject objectForKey:@"list"];
        for (int i = 0; i<init.count; i++) {
            [data addObject:[init objectAtIndex:i]];
        }
         [_tableview reloadData];
        //NSLog(@"%d",data.count);
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        
        [self qq_performSVHUDBlock:^{
            [SVProgressHUD showErrorWithStatus:@"账号或密码错误"];
        }];
    }];


    
    // 2.模拟2秒后刷新表格UI（真实开发中，可以移除这段gcd代码）
    
        // 刷新表格
    
        
        // 拿到当前的上拉刷新控件，结束刷新状态
        [_tableview.mj_footer endRefreshing];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - tableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    NSLog(@"%lu",(unsigned long)data.count);
    return data.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%@",data);
    static NSString *CellIdentifier = @"cell";
    // 通过indexPath创建cell实例 每一个cell都是单独的
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    // 判断为空进行初始化  --（当拉动页面显示超过主页面内容的时候就会重用之前的cell，而不会再次初始化）
    if (!cell) {
        
        //创建客户名称lab
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        UILabel* lab=[[UILabel alloc]initWithFrame:CGRectMake(8, 16, 300, 21)];
        lab.font=[UIFont systemFontOfSize:16];
        lab.textColor=[UIColor redColor];
        lab.tag=148;
        [cell.contentView addSubview:lab];
        //创建下划线
        
        UIView* line=[[UIView alloc]initWithFrame:CGRectMake(0, 45, ScreenWidth, 1)];
        line.backgroundColor=[UIColor lightGrayColor];
        [cell.contentView addSubview:line];
        
        //创建添加联系人按钮
        UIButton* btnadd=[[UIButton alloc]initWithFrame:CGRectMake(ScreenWidth-40, 55, 30, 30)];
        [btnadd setImage:[UIImage imageNamed:@"add"] forState:UIControlStateNormal];
        [cell.contentView addSubview:btnadd];
        [btnadd addTarget:self action:@selector(addContactsClick:) forControlEvents:UIControlEventTouchUpInside];
        
        //创建客户详情按钮
        UIButton* btnto=[[UIButton alloc]initWithFrame:CGRectMake(ScreenWidth-40, 7, 30, 30)];
        [btnto setImage:[UIImage imageNamed:@"toright"] forState:UIControlStateNormal];
        [cell.contentView addSubview:btnto];
        [btnto addTarget:self action:@selector(clickToTaba:) forControlEvents:UIControlEventTouchUpInside];
    }
        NSDictionary* customer=[data objectAtIndex:[indexPath row]];
        NSString* custo_id=[customer objectForKey:@"id"];//获取客户id
        NSString* custo_name=[customer objectForKey:@"cus_name"];//客户名称 公司或者个体户
        ((UILabel*)[cell.contentView viewWithTag:148]).text=custo_name;
        NSArray* contacts=[customer objectForKey:@"contacts"];//联系人数组
        NSString* contacts_phone,*contacts_name,*contacts_id;
        int jgx=0;
        //多的话默认显示前3个
        if (contacts.count>=3) {
            for (int i=0; i<3; i++) {
                NSDictionary * contact=[contacts objectAtIndex:i];
                contacts_phone=[contact objectForKey:@"CONTACTS_PHONE"];
                contacts_name=[contact objectForKey:@"CONTACTS_NAME"];
                
                contacts_id=[contact objectForKey:@"CONTACTS_ID"];
                int jgx=0;
                UIButton * btn_contact=[[UIButton alloc]initWithFrame:CGRectMake(0, 60, 70, 25)];
                [btn_contact addTarget:self action:@selector(call) forControlEvents:UIControlEventTouchUpInside];
                [btn_contact.titleLabel setFont:[UIFont systemFontOfSize:12]];
                
                [btn_contact setTitle:contacts_name forState:UIControlStateNormal];
                [btn_contact setImage:[UIImage imageNamed:@"phone"]  forState:UIControlStateNormal];
                btn_contact.tag=[indexPath row]*100+i;
                jgx=+90;
                [cell.contentView addSubview:btn_contact];
            }
        }
        else
        {
            for (int i=0; i<contacts.count; i++) {
                NSDictionary * contact=[contacts objectAtIndex:i];
                contacts_phone=[contact objectForKey:@"CONTACTS_PHONE"];
                contacts_name=[contact objectForKey:@"CONTACTS_NAME"];
                contacts_id=[contact objectForKey:@"CONTACTS_ID"];
                
                UIButton * btn_contact=[[UIButton alloc]initWithFrame:CGRectMake(15+jgx, 60, 70, 25)];
                [btn_contact addTarget:self action:@selector(call) forControlEvents:UIControlEventTouchUpInside];
                [btn_contact setTitle:contacts_name forState:UIControlStateNormal];
                btn_contact.titleLabel.font = [UIFont systemFontOfSize: 12.0];
                [btn_contact setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                [btn_contact setImage:[UIImage imageNamed:@"phone"]  forState:UIControlStateNormal];
                [[Utility sharedInstance] setLayerView:btn_contact borderW:1 borderColor:[UIColor redColor] radius:4];
                btn_contact.tag=[indexPath row]*100+i;
                jgx=+90;
                [cell.contentView addSubview:btn_contact];
            }
        }
    
    
    
    
    return cell;
    
}
-(void)call
{
    NSLog(@"打电话中");
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 15;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0;
}

-(void)clickToTaba:(id)sender
{
    toIndex=0;
    [self performSegueWithIdentifier:@"toTab" sender:nil];
}

-(void)addContactsClick:(id)sender
{
    toIndex=2;
    [self performSegueWithIdentifier:@"toTab" sender:nil];
    
}


#pragma mark - Navigation
//
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"toTab"])
    {
        XNTabBarController* destinationController=segue.destinationViewController;
        destinationController.index=toIndex;
        
    }
}


//导航栏右边侧边栏展开按钮
- (IBAction)rightMenuClick:(id)sender {
    //判断是否打开，做出不同响应
    if ([self.viewDeckController isSideOpen:IIViewDeckRightSide]) {//已经打开
        [self.viewDeckController closeRightView];//则关闭左视图
        }
    else {//未打开
        [self.viewDeckController openRightView];//则打开左视图
        
    }

}


//添加客户按钮
- (IBAction)addClientClick:(id)sender {
    
}

//位置按钮
- (IBAction)locationClick:(id)sender {
}
@end
