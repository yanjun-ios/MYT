//
//  CusMarkViewController.m
//  MYT
//
//  Created by 熊凯 on 16/1/11.
//  Copyright © 2016年 YunRui. All rights reserved.
//

#import "CusMarkViewController.h"
#import "NetRequestManager.h"
#import "QQRequestManager.h"
#import "MJRefresh.h"
@interface CusMarkViewController ()
{
    int clientId;
    int num;
    NSMutableArray* arry;

}
@end

@implementation CusMarkViewController

-(void)viewWillLayoutSubviews
{
   

}

- (void)viewDidLoad {
    if(currentVersion>=7)
    {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.automaticallyAdjustsScrollViewInsets = NO;
    }

     [super viewDidLoad];
    self.title=@"备注列表";
    arry=[[NSMutableArray alloc]init];
    num=1;
    clientId=[NetRequestManager sharedInstance].clientId;
    _tableview.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loaData)];
    _tableview.mj_footer.automaticallyHidden =YES;
    [_tableview.mj_footer beginRefreshing];
    _tableview.delegate=self;
    _tableview.dataSource=self;
    
    _tableview.sectionFooterHeight=0;
    _tableview.sectionHeaderHeight=10;
    _tableview.rowHeight=UITableViewAutomaticDimension;
    _tableview.estimatedRowHeight=44.0;//这个必须加上，否则出现高度无法自适应问题。
    // Do any additional setup after loading the view.
}
-(void)loaData
{
    NSString* NUM = [NSString stringWithFormat:@"%d",num];
    NSString* cusid=[NSString stringWithFormat:@"%d",clientId];
    NSMutableDictionary* parDic=[[NSMutableDictionary alloc]initWithCapacity:10];
    [parDic setValue:[[NSUserDefaults standardUserDefaults]objectForKey:@"user_id"] forKey:@"userid"];
    [parDic setObject:cusid forKey:@"cusid"];
    [parDic setObject:@5 forKey:@"pageSize"];
    [parDic setObject:NUM forKey:@"pageNum"];
   // 获取备注列表的接口没有
    [[QQRequestManager sharedRequestManager] GET:[SEVER_URL stringByAppendingString:@"yd/getCusCallLogList.action"] parameters:parDic showHUD:YES success:^(NSURLSessionDataTask *task, id responseObject) {
//        num++;
//        NSDictionary* dic=responseObject;
//        NSArray* trading_record=[dic objectForKey:@"cus_remark"];
//        [arry addObjectsFromArray:trading_record];
        [_tableview reloadData];
        [_tableview.mj_footer endRefreshing];
    
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}
//taleview代理方法
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* identifi=@"cell";
    UITableViewCell* cell;
    cell=[_tableview dequeueReusableCellWithIdentifier:identifi];
    if(!cell)
    {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifi];
    }
    
    ((UILabel*)[cell.contentView viewWithTag:1000]).text=@"2013-23-89";
    ((UILabel*)[cell.contentView viewWithTag:1001]).text=@"你的看法噶电话噶电话噶看得开；好卡机和；的快感几乎都是； 啊好；卡的很高；阿卡家；阿卡多废话 ；看哈的；按时开放和思考；飞";
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    return [arry count];
        return 5;
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
