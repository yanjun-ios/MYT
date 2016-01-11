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

- (void)viewDidLoad {
    self.title=@"通话记录";
    arry=[[NSMutableArray alloc]init];
    num=1;
    clientId=[NetRequestManager sharedInstance].clientId;
    _tableview.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loaData)];
    _tableview.mj_footer.automaticallyHidden = NO;
    [_tableview.mj_footer beginRefreshing];
    _tableview.delegate=self;
    _tableview.dataSource=self;
    
    _tableview.sectionFooterHeight=0;
    _tableview.sectionHeaderHeight=10;
    _tableview.rowHeight=UITableViewAutomaticDimension;
    _tableview.estimatedRowHeight=44.0;//这个必须加上，否则出现高度无法自适应问题。
    [super viewDidLoad];
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
    //获取备注列表的接口没有
//    [[QQRequestManager sharedRequestManager] GET:[SEVER_URL stringByAppendingString:@"yd/getCusCallLogList.action"] parameters:parDic showHUD:YES success:^(NSURLSessionDataTask *task, id responseObject) {
//        num++;
//        NSDictionary* dic=responseObject;
//        NSArray* trading_record=[dic objectForKey:@"cus_remark"];
//        [arry addObjectsFromArray:trading_record];
//        [_tableview reloadData];
//        [_tableview.mj_footer endRefreshing];
//    
//    } failure:^(NSURLSessionDataTask *task, NSError *error) {
//        
//    }];
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
//        //姓名
//        UILabel* trading_dlvdate=[[UILabel alloc]initWithFrame:CGRectMake(20, 10, 50, 20)];
//        trading_dlvdate.font=[UIFont systemFontOfSize:14];
//        trading_dlvdate.textColor=[UIColor darkGrayColor];
//        trading_dlvdate.tag=1000;
//        [cell.contentView addSubview:trading_dlvdate];
//        //电话
//        UILabel* dlvdate=[[UILabel alloc]initWithFrame:CGRectMake(80, 10, 200, 20)];
//        dlvdate.font=[UIFont systemFontOfSize:14];
//        dlvdate.textColor=[UIColor darkGrayColor];
//        dlvdate.tag=1001;
//        [cell.contentView addSubview:dlvdate];
//        
//        //时间
//        UILabel* trading_obdcode=[[UILabel alloc]initWithFrame:CGRectMake(20, 40, 150, 20)];
//        trading_obdcode.font=[UIFont systemFontOfSize:14];
//        trading_obdcode.textColor=[UIColor darkGrayColor];
//        trading_obdcode.tag=1002;
//        [cell.contentView addSubview:trading_obdcode];
//        
//        //通话时长
//        UILabel* talk_time=[[UILabel alloc]initWithFrame:CGRectMake(180, 40, 70, 20)];
//        talk_time.font=[UIFont systemFontOfSize:14];
//        talk_time.textColor=[UIColor darkGrayColor];
//        talk_time.text=@"通话时长：";
//        [cell.contentView addSubview:talk_time];
//        //通话时间
//        UILabel* obdcode=[[UILabel alloc]initWithFrame:CGRectMake(260, 40, 60, 20)];
//        obdcode.font=[UIFont systemFontOfSize:14];
//        obdcode.textColor=[UIColor darkGrayColor];
//        obdcode.tag=1003;
//        [cell.contentView addSubview:obdcode];
    }
    
    ((UILabel*)[cell.contentView viewWithTag:1000]).text=@"2013-23-89";
    ((UILabel*)[cell.contentView viewWithTag:1001]).text=@"你的看法噶电话噶电话噶看得开；好卡机和；的快感几乎都是； 啊好；卡的很高；阿卡家；阿卡多废话 ；看哈的；按时开放和思考；飞";
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    return [arry count];
        return 10;
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
