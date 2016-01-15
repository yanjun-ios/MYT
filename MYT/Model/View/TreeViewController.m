//
//  TreeViewController.m
//  MYT
//
//  Created by yunruiinfo on 16/1/15.
//  Copyright © 2016年 YunRui. All rights reserved.
//

#import "TreeViewController.h"
#import "Node.h"
#import "ButtomView.h"
@interface TreeViewController ()
{
    NSArray *init;
    NSMutableArray *nodear;//要显示的所有node数据 //三级
    NSMutableArray *_tempedata;//所有数据起来
    __block  NSMutableArray  *typearr;//存类型为T的物料类别
    __block  NSMutableArray  *wularr;//存类型为W的物料类别
}
@end

@implementation TreeViewController
-(void)viewWillAppear:(BOOL)animated
{
    ButtomView* BtmV=[[ButtomView alloc]initWithFrame:CGRectMake(0, ScreenHeight-49, ScreenWidth, 50)];
    [self.view addSubview:BtmV];
     self.navigationController.navigationBarHidden=NO;
    
}
-(void)initwithnodear
{
    [_tempedata removeAllObjects];
    for (int i=0; i<nodear.count; i++) {
        for (int j=0; j<((NSMutableArray*)[nodear objectAtIndex:i]).count; j++) {
            [_tempedata addObject:[(NSMutableArray*)[nodear objectAtIndex:i] objectAtIndex:j]];
        }
    }//暂时测试2级
   // [_tableView reloadData];
}
- (void)viewDidLoad {
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    _tempedata=[[NSMutableArray alloc]init];
    nodear=[[NSMutableArray alloc] init];
    typearr=[[NSMutableArray alloc]init];
    wularr=[[NSMutableArray alloc]init];
    nodear=[[NSMutableArray alloc]init];
    for(int i=0;i<_nodearr.count;i++)
    {
        NSMutableArray *nodea=[[NSMutableArray alloc]init];//创建每行
        [nodea addObject:[_nodearr objectAtIndex:i]];//将第一层的node分别加入不同的可变数组
        
        [nodear addObject:nodea];
    }
    [self initwithnodear];
    NSLog(@"%@",_tempedata);
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _tempedata.count;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Node *node = [_tempedata objectAtIndex:indexPath.row];
    
    static NSString *NODE_CELL_ID ;
   /* if (node.depth==0||node.depth==1) {
        NODE_CELL_ID = @"node_cell_id0";
        
        
        
    }*/
    /*else if(node.depth==1)
     {
     NODE_CELL_ID = @"node_cell_id1";
     }*/
    //else if(node.depth==2)
    //{
        NODE_CELL_ID = @"node_cell_id2";
    //}
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:NODE_CELL_ID];
    if (!cell) {
            
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NODE_CELL_ID];
            //数量
            UILabel* count;
            count=[[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth/2-25, 15, 50, 15)];
        
            count.tag=11;
            count.textColor=[UIColor redColor];
            count.font=[UIFont systemFontOfSize:14];
            count.textAlignment=NSTextAlignmentCenter;
            [cell.contentView addSubview:count];
            
            //匹配客户
            UILabel* men;
            men=[[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth-80, 15, 80, 15)];
            men.tag=12;
            men.textColor=[UIColor greenColor];
            men.font=[UIFont systemFontOfSize:14];
            men.textAlignment=NSTextAlignmentCenter;
            [cell.contentView addSubview:men];
            
            UIImageView *image=[[UIImageView alloc] init];
            image.tag=13;
            //if(node.child)
            // {
            
            if (node.depth==0) {
                NSLog(@"%@",node.name);
                image.frame=CGRectMake(2, 16,8, 8);
           }
            
            else
            {
                NSLog(@"%@",node.name);
                image.frame=CGRectMake(25, 16,8, 8);
            }
        
            
            
            //image.image=[UIImage imageNamed:@"left"];
            [cell.contentView addSubview:image];
        }
    UILabel* label2=(UILabel*)[cell.contentView viewWithTag:11];
    label2.text=@"z";
    
    UILabel* label3=(UILabel*)[cell.contentView viewWithTag:12];
    label3.text=@"3";
    
    UIImageView *image=(UIImageView*)[cell.contentView viewWithTag:13];
    image.image=[UIImage imageNamed:@"公司库存向右"];
    
    
    
    //
    // cell有缩进的方法
    cell.indentationLevel = node.depth; // 缩进级别
    cell.indentationWidth = 30.f; // 每个缩进级别的距离
    
    
    //    NSMutableString *name = [NSMutableString string];
    //    for (int i=0; i<node.depth; i++) {
    //        [name appendString:@"     "];
    //    }
    
    //    [name appendString:node.name];
    cell.textLabel.text = node.name;

    return cell;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
     Node *parentNode = [_tempedata objectAtIndex:indexPath.row];
    NSLog(@"%hd",parentNode.expand);
    __block  NSUInteger startPosition = indexPath.row+1;
    __block  NSUInteger endPosition = startPosition;
    
    if(parentNode.depth==0)
    {
        NSMutableArray * arr=[[NSMutableArray alloc]init];
        __block int j;
        for (int i=0;i<_nodearr.count;i++) {
            if (((Node*)[_nodearr objectAtIndex:i]).nodeId==parentNode.nodeId) {
                arr=(NSMutableArray*)[nodear objectAtIndex:i];
                j=i;
            }
        }
        
        NSMutableDictionary* parDic=[[NSMutableDictionary alloc]initWithCapacity:10];
        [parDic setValue:[[NSUserDefaults standardUserDefaults]objectForKey:@"user_id"] forKey:@"userid"];
        NSLog(@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"user_id"]);
        NSString *nodeid=[NSString stringWithFormat:@"%d",parentNode.nodeId];
        [parDic setValue:nodeid forKey:@"parentid"];
        [[QQRequestManager sharedRequestManager] GET:[SEVER_URL stringByAppendingString:@"yd/getMatTree.action"] parameters:parDic showHUD:YES success:^(NSURLSessionDataTask *task, id responseObject) {
            NSLog(@"%@",responseObject);
            init=[responseObject objectForKey:@"list"];
            for (NSDictionary *dic in init) {
                if ([[dic objectForKey:@"tw"] isEqualToString:@"T"]) {
                    [typearr addObject:dic];
                }
                else
                {
                    [wularr addObject:dic];
                }
            }
            for (int i=0; i<typearr.count; i++) {
                NSDictionary * typeinfo=[typearr objectAtIndex:i];
                int nodeid=((NSNumber*)[typeinfo objectForKey:@"typeid"]).intValue;
                Node * node1=[[Node alloc]initWithParentId:parentNode.nodeId nodeId:nodeid name:[typeinfo objectForKey:@"typename"] depth:1 expand:YES child:YES];
                
                if (parentNode.expand) {
                    NSLog(@"%@",[nodear objectAtIndex:j]);
                    [(NSMutableArray*)[nodear objectAtIndex:j] addObject:node1];//增加
                    endPosition++;
                  
                    
                }
                else
                {
                    for (int i=0; i<((NSMutableArray*)[nodear objectAtIndex:j]).count; i++) {
                        Node * nod=[(NSMutableArray*)[nodear objectAtIndex:j] objectAtIndex:i];
                        if (nod.nodeId==nodeid) {
                            [(NSMutableArray*)[nodear objectAtIndex:j] removeObject:nod];//移除
                        }
                     
                        
                    }
                    
                    
                }
                
            }
            if (!parentNode.expand) {
                endPosition = [self removeAllNodesAtParentNode:parentNode];
            }
           
            NSLog(@"%@",nodear);
            for (int i=0; i<wularr.count; i++) {
                NSDictionary * wulinfo=[wularr objectAtIndex:i];
                int nodeid=((NSNumber*)[wulinfo objectForKey:@"matid"]).intValue;
                Node * node1=[[Node alloc]initWithParentId:parentNode.nodeId nodeId:nodeid name:[wulinfo objectForKey:@"mattername"] depth:1 expand:NO child:NO];
                [nodear addObject:node1];
                
            }
            NSLog(@"%@",nodear);
            [typearr removeAllObjects];
            [wularr removeAllObjects];
            [self initwithnodear];
           
            NSMutableArray *indexPathArray = [NSMutableArray array];
            //修正indexpath
            for (NSUInteger i=startPosition; i<endPosition; i++) {
                NSIndexPath *tempIndexPath = [NSIndexPath indexPathForRow:i inSection:0];
                [indexPathArray addObject:tempIndexPath];
            }
            if (parentNode.expand) {
                [self.tableView insertRowsAtIndexPaths:indexPathArray withRowAnimation:UITableViewRowAnimationNone];
            }else{
                [self.tableView deleteRowsAtIndexPaths:indexPathArray withRowAnimation:UITableViewRowAnimationNone];
            }
        
              parentNode.expand=!parentNode.expand;
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            
            
            [self qq_performSVHUDBlock:^{
                [SVProgressHUD showErrorWithStatus:@"账号或密码错误"];
            }];
        }];
        
        //  }
        // else
        // {
        
        // }
        
    }
}
/**
 *  删除该父节点下的所有子节点（包括孙子节点）
 *
 *  @param parentNode 父节点
 *
 *  @return 该父节点下一个相邻的统一级别的节点的位置
 */
-(NSUInteger)removeAllNodesAtParentNode : (Node *)parentNode{
   
    NSUInteger startPosition = [_tempedata indexOfObject:parentNode];
    NSLog(@"%d",parentNode.depth);
    NSLog(@"%d",startPosition);
    NSUInteger endPosition = startPosition;
    for (NSUInteger i=startPosition+1; i<_tempedata.count; i++) {
        Node *node = [_tempedata objectAtIndex:i];
        endPosition++;
        if (node.depth <= parentNode.depth) {
            break;
        }
        if(endPosition == _tempedata.count-1){
            endPosition++;
            node.expand = NO;
            break;
        }
        node.expand = NO;
    }
    if (endPosition>startPosition) {
        [_tempedata removeObjectsInRange:NSMakeRange(startPosition+1, endPosition-startPosition-1)];
    }
    return endPosition;
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
