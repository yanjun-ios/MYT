//
//  ProductdetalViewController.m
//  MYT
//
//  Created by YUNRUIMAC on 15/12/15.
//  Copyright © 2015年 YunRui. All rights reserved.
//

#import "ProductdetalViewController.h"
#import "ButtomView.h"
#import "MJRefresh.h"
#import "Utility.h"
@interface ProductdetalViewController ()
{
    int zf;
    int totlepage;
    NSArray * jsonarr;
    NSMutableArray *date;
    int isInSearch;
    int searMorePageNum;
}

@end

@implementation ProductdetalViewController

- (void)viewDidLoad {
    _topSearchBar.delegate=self;
    ButtomView* BtmV=[[ButtomView alloc]initWithFrame:CGRectMake(0, ScreenHeight-49, ScreenWidth, 50)];
    [self.view addSubview:BtmV];
    date=[[NSMutableArray alloc]init];
    _tableView.dataSource=self;
    _tableView.delegate=self;
    //zf=1;
    _tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated
{
      [self initinfo];
}
-(void)viewDidAppear:(BOOL)animated
{
    NSLog(@"%@",jsonarr);
    [_tableView reloadData];
    
    
}
-(void)initinfo
{
    zf=1;
    NSMutableDictionary* parDic=[[NSMutableDictionary alloc]initWithCapacity:10];
    [parDic setValue:_matid forKey:@"typeid"];
    //NSLog(@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"user_id"]);
    //NSString* num=[NSString stringWithFormat:@"%d",zf];
    [parDic setValue:@10 forKey:@"pageSize"];
    [parDic setValue:@1 forKey:@"pageNum"];
    
    if (_topSearchBar.text.length==0||[_topSearchBar.text isEqualToString:@" "]) {
        [parDic setValue:@"" forKey:@"searchtext"];
    }else
    {
        [parDic setValue:_topSearchBar.text forKey:@"searchtext"];
    }
    [[QQRequestManager sharedRequestManager] GET:[SEVER_URL stringByAppendingString:@"yd/getMatDtl.action"] parameters:parDic showHUD:YES success:^(NSURLSessionDataTask *task, id responseObject) {
            totlepage=((NSNumber*)[responseObject objectForKey:@"totlePage"]).intValue;
            jsonarr=[responseObject objectForKey:@"list"];
            [date removeAllObjects];
            [date addObjectsFromArray:jsonarr];
            [_tableView reloadData];
                        //将请求到的第一层数据分类
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            [self qq_performSVHUDBlock:^{
                [SVProgressHUD showErrorWithStatus:@"请求数据失败"];
            }];
        }];
}

- (void)loadMoreData
{
    // 1.添加假数据
    if (zf<totlepage+1) {
        zf++;
        NSMutableDictionary* parDic=[[NSMutableDictionary alloc]initWithCapacity:10];
        [parDic setValue:_matid forKey:@"typeid"];
        NSString* num=[NSString stringWithFormat:@"%d",zf];
        [parDic setValue:@10 forKey:@"pageSize"];
        [parDic setValue:num forKey:@"pageNum"];
        [parDic setValue:_topSearchBar.text forKey:@"searchtext"];
        [[QQRequestManager sharedRequestManager] GET:[SEVER_URL stringByAppendingString:@"yd/getMatDtl.action"] parameters:parDic showHUD:YES success:^(NSURLSessionDataTask *task, id responseObject) {
            //totlepage=((NSNumber*)[responseObject objectForKey:@"totlePage"]).intValue;
            jsonarr=[responseObject objectForKey:@"list"];
            [date addObjectsFromArray:jsonarr];
            [_tableView reloadData];
            //将请求到的第一层数据分类
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            
            
            [self qq_performSVHUDBlock:^{
                [SVProgressHUD showErrorWithStatus:@"请求数据失败"];
            }];
        }];
    }
    else
    {
        [SVProgressHUD showErrorWithStatus:@"已经到底啦"];
    }
    
    
    
    // 2.模拟2秒后刷新表格UI（真实开发中，可以移除这段gcd代码）
    
    // 刷新表格
    
    
    // 拿到当前的上拉刷新控件，结束刷新状态
    [_tableView.mj_footer endRefreshing];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return  0;
}
/*- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, _tableView.frame.size.width, 60)];
    UIView *view1=[[UIView alloc]initWithFrame:CGRectMake(0, 0,  _tableView.frame.size.width, 35)];
    UIView *view2=[[UIView alloc]initWithFrame:CGRectMake(0, 35,  _tableView.frame.size.width, 25)];
    view2.backgroundColor=[UIColor lightGrayColor];
    
    UILabel *jibie=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, _tableView.frame.size.width, 35)];
    jibie.textColor=[UIColor orangeColor];
    jibie.text=[NSString stringWithFormat:@"%@>%@>%@",_depth0,_depth1,_depth2];
    jibie.font=[UIFont fontWithName:@"ArialMT" size:14];
    [view1 addSubview:jibie];
    
    UILabel *length=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, tableView.frame.size.width/3, 25)];
    length.textColor=[UIColor blackColor];
    length.text=@"长度";
    length.textAlignment=NSTextAlignmentCenter;
    length.font=[UIFont fontWithName:@"ArialMT" size:14];
    
    UILabel *from=[[UILabel alloc]initWithFrame:CGRectMake(tableView.frame.size.width/3, 0, tableView.frame.size.width/3, 25)];
    from.textColor=[UIColor blackColor];
    from.text=@"产地";
    from.textAlignment=NSTextAlignmentCenter;
    from.font=[UIFont fontWithName:@"ArialMT" size:14];
    
    
    UILabel *count=[[UILabel alloc]initWithFrame:CGRectMake(tableView.frame.size.width*2/3, 0, tableView.frame.size.width/3, 25)];
    count.textColor=[UIColor blackColor];
    count.textAlignment=NSTextAlignmentCenter;
    count.text=@"数量";
    count.font=[UIFont fontWithName:@"ArialMT" size:14];
    
    
    [view2 addSubview:length];
    [view2 addSubview:from];
    [view2 addSubview:count];
    
    [view addSubview:view1];
    [view addSubview:view2];
    return view;
}*/
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    NSDictionary* maitinfo=[date objectAtIndex:indexPath.row];
    UILabel* maitname=(UILabel*)[cell.contentView viewWithTag:120];
    maitname.text=[maitinfo objectForKey:@"matterName"];
    UILabel* maticount=(UILabel*)[cell.contentView viewWithTag:121];
    maticount.text=((NSNumber*)[maitinfo objectForKey:@"invCt"]).stringValue;
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return date.count;
}

#pragma mark -- searchbar Delegat Method
-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    [self initinfo];
    
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
