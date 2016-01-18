//
//  ChangeinfoTableViewController.m
//  MYT
//
//  Created by YUNRUIMAC on 16/1/10.
//  Copyright © 2016年 YunRui. All rights reserved.
//

#import "ChangeinfoTableViewController.h"
#import "Node1.h"
#import "AddneedViewController.h"
#import "NetRequestManager.h"
#import "QQRequestManager.h"
@interface ChangeinfoTableViewController ()
{
    NSArray *init;
    NSMutableArray *nodear;
    __block  NSMutableArray  *typear;//存类型为T的物料类别
    __block  NSMutableArray  *wular;//存类型为W的物料类别
    __block NSArray *jsonary;
}
@end

@implementation ChangeinfoTableViewController
-(void)viewWillAppear:(BOOL)animated
{
    UIBarButtonItem *rightBtn = [[UIBarButtonItem alloc]
                                 
                                 initWithImage:[UIImage imageNamed:@"02-1通讯录30-30"]
                                 
                                 style:UIBarButtonItemStyleDone
                                 
                                 target:self
                                 
                                 action:@selector(finishclick)];
    //barbtn.image=searchimage;
    //self.navigationItem.rightBarButtonItem=barbtn;
    self.tabBarController.navigationItem.rightBarButtonItem = rightBtn;
    [self getstock];
    [self getneed];
   
}
- (void)viewDidLoad {
    
    //消除多余空白行
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    [self.tableView setTableFooterView:view];
    
    _clientId= [NetRequestManager sharedInstance].clientId;
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    nodear=[[NSMutableArray alloc]init];
    typear=[[NSMutableArray alloc]init];
    wular=[[NSMutableArray alloc]init];
    UIBarButtonItem *rightBtn = [[UIBarButtonItem alloc]
                                 
                                 initWithImage:[UIImage imageNamed:@"02-1通讯录30-30"]
                                 
                                 style:UIBarButtonItemStyleDone
                                 
                                 target:self
                                 
                                 action:@selector(finishclick)];
    //barbtn.image=searchimage;
    //self.navigationItem.rightBarButtonItem=barbtn;
    self.tabBarController.navigationItem.rightBarButtonItem = rightBtn;
    
    
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView * view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 50)];
    //物料或者物料规格名字
    UILabel* name=[[UILabel alloc]initWithFrame:CGRectMake(10, 11, 60, 20)];
    name.font=[UIFont systemFontOfSize:14];
    name.textColor=[UIColor lightGrayColor];
    name.text=@"名称";
    [view addSubview:name];
    
    //是物料还是物料规格
    UILabel* phone=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 80, 20)];
    phone.center=CGPointMake(ScreenWidth/2, 21);
    phone.textAlignment=NSTextAlignmentCenter;
    phone.font=[UIFont systemFontOfSize:14];
    phone.textColor=[UIColor lightGrayColor];
    phone.text=@"类型";
    [view addSubview:phone];
    
    
    UILabel* need=[[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth-60, 11, 60, 20)];
    need.font=[UIFont systemFontOfSize:14];
    need.textColor=[UIColor lightGrayColor];
    need.text=@"需求量";
    [view addSubview:need];

    return view;
}
-(void)getneed
{
    NSString * clientidstr=[NSString stringWithFormat:@"%d",_clientId];
    NSMutableDictionary* parDic=[[NSMutableDictionary alloc]init];
    [parDic setValue:clientidstr forKey:@"cusid"];
    [parDic setValue:[[NSUserDefaults standardUserDefaults]objectForKey:@"user_id"] forKey:@"userid"];
    [[QQRequestManager sharedRequestManager]GET:[SEVER_URL stringByAppendingString:@""] parameters:parDic showHUD:YES success:^(NSURLSessionDataTask *task, id responseObject) {
        jsonary=[responseObject objectForKey:@"list"];
        [self.tableView reloadData];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [self qq_performSVHUDBlock:^{
            [SVProgressHUD showErrorWithStatus:@"网络请求错误！"];
        }];
    }];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return  jsonary.count;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* identif=@"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identif];
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identif];
        
        //物料或者物料规格名字
        UILabel* name=[[UILabel alloc]initWithFrame:CGRectMake(10, 11, 60, 20)];
        name.font=[UIFont systemFontOfSize:14];
        name.textColor=[UIColor darkGrayColor];
        name.tag=1000;
        [cell.contentView addSubview:name];
        
        //是物料还是物料规格
        UILabel* phone=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 80, 20)];
        phone.center=CGPointMake(ScreenWidth/2, 21);
        phone.textAlignment=NSTextAlignmentCenter;
        phone.font=[UIFont systemFontOfSize:14];
        phone.textColor=[UIColor darkGrayColor];
        phone.tag=1001;
        [cell.contentView addSubview:phone];
        
  
        UILabel* need=[[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth-60, 11, 60, 20)];
        need.font=[UIFont systemFontOfSize:14];
        need.textColor=[UIColor darkGrayColor];
        need.tag=1002;
        [cell.contentView addSubview:need];
    }
    if ([[[jsonary objectAtIndex:indexPath.row] objectForKey:@"tw"] isEqualToString:@"T"]) {
        ((UILabel*)[cell.contentView viewWithTag:1000]).text=[[jsonary objectAtIndex:indexPath.row] objectForKey:@"typename"];
        ((UILabel*)[cell.contentView viewWithTag:1001]).text=@"物料规格";
        ((UILabel*)[cell.contentView viewWithTag:1002]).text=[[jsonary objectAtIndex:indexPath.row] objectForKey:@"needs"];
    }
    else
    {
        ((UILabel*)[cell.contentView viewWithTag:1000]).text=[[jsonary objectAtIndex:indexPath.row] objectForKey:@"mattername"];
        ((UILabel*)[cell.contentView viewWithTag:1001]).text=[[jsonary objectAtIndex:indexPath.row] objectForKey:@"spec"];
        ((UILabel*)[cell.contentView viewWithTag:1002]).text=[[jsonary objectAtIndex:indexPath.row] objectForKey:@"needs"];
    }
    
    
    
    return cell;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)finishclick
{
    if (nodear.count) {
         [self performSegueWithIdentifier:@"addneed" sender:self];
    }
    else
        [SVProgressHUD showErrorWithStatus:@"请求数据失败"];
   
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqual:@"addneed"]) {
        AddneedViewController * stock=segue.destinationViewController;
        stock.nodearr=nodear;
    }
}

#pragma mark - Table view data source

-(void)getstock
{
    
    [nodear removeAllObjects];
    [typear removeAllObjects];
    [wular removeAllObjects];
    NSLog(@"%@",nodear);
    NSMutableDictionary* parDic=[[NSMutableDictionary alloc]initWithCapacity:10];
    [parDic setValue:[[NSUserDefaults standardUserDefaults]objectForKey:@"user_id"] forKey:@"userid"];
    NSLog(@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"user_id"]);
    [parDic setValue:@"null" forKey:@"parentid"];
    dispatch_queue_t concurrentQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    dispatch_sync(concurrentQueue, ^{
        [[QQRequestManager sharedRequestManager] GET:[SEVER_URL stringByAppendingString:@"yd/getMatTree.action"] parameters:parDic showHUD:YES success:^(NSURLSessionDataTask *task, id responseObject) {
            [nodear removeAllObjects];
            init=[responseObject objectForKey:@"list"];
            for (NSDictionary *dic in init) {
                if ([[dic objectForKey:@"tw"] isEqualToString:@"T"]) {
                    [typear addObject:dic];
                }
                else
                {
                    [wular addObject:dic];
                }
            }
            for (int i=0; i<typear.count; i++) {
                NSDictionary * typeinfo=[typear objectAtIndex:i];
                int nodeid=((NSNumber*)[typeinfo objectForKey:@"typeid"]).intValue;
                int counts=((NSNumber*)[typeinfo objectForKey:@"counts"]).intValue;
                Node1 * node=[[Node1 alloc]initWithParentId:-1 nodeId:nodeid name:[typeinfo objectForKey:@"typename"] depth:0 expand:YES child:YES matid:-1 typid:nodeid needcount:counts];
                [nodear addObject:node];
            }
            for (int i=0; i<wular.count; i++) {
                NSDictionary * wulinfo=[wular objectAtIndex:i];
                int nodeid=((NSNumber*)[wulinfo objectForKey:@"matid"]).intValue;
                int counts=((NSNumber*)[wulinfo objectForKey:@"counts"]).intValue;
                Node1 * node=[[Node1 alloc]initWithParentId:-1 nodeId:nodeid name:[wulinfo objectForKey:@"mattername"] depth:0 expand:YES child:NO matid:nodeid typid:-1 needcount:counts];
                [nodear addObject:node];
                
            }
            NSLog(@"%@",nodear);
            
            //将请求到的第一层数据分类
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            
            
            [self qq_performSVHUDBlock:^{
                [SVProgressHUD showErrorWithStatus:@"请求数据失败"];
            }];
        }];
        
        /*download the image here*/
        
    });
    
}


/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
