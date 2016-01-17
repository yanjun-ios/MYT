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
@interface ChangeinfoTableViewController ()
{
    NSArray *init;
    NSMutableArray *nodear;
    __block  NSMutableArray  *typear;//存类型为T的物料类别
    __block  NSMutableArray  *wular;//存类型为W的物料类别
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
   
}
- (void)viewDidLoad {
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
    _TF_ChuanZ.delegate=self;
    _TF_name.delegate=self;
    _TF_need.delegate=self;
    _TF_phone.delegate=self;
    _TF_singlename.delegate=self;
    _TF_Website.delegate=self;
    
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
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
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
   
    UIWindow * window=[[[UIApplication sharedApplication] delegate] window];
    CGRect rect=[textField convertRect:textField.bounds toView:window];
    float y1=rect.origin.y;
    if(y1>200)
    {
        self.tableView.frame=CGRectMake(0, -y1+200, ScreenWidth, ScreenHeight);
    }
}
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    self.tableView.frame=CGRectMake(0, 0, ScreenWidth, ScreenHeight-50);
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
                Node1 * node=[[Node1 alloc]initWithParentId:-1 nodeId:nodeid name:[typeinfo objectForKey:@"typename"] depth:0 expand:YES child:YES matid:-1 typid:nodeid needcount:-1];
                [nodear addObject:node];
            }
            for (int i=0; i<wular.count; i++) {
                NSDictionary * wulinfo=[wular objectAtIndex:i];
                int nodeid=((NSNumber*)[wulinfo objectForKey:@"matid"]).intValue;
                Node1 * node=[[Node1 alloc]initWithParentId:-1 nodeId:nodeid name:[wulinfo objectForKey:@"mattername"] depth:0 expand:YES child:NO matid:nodeid typid:-1 needcount:-1];
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
