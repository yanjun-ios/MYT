//
//  StockViewController.m
//  MYT
//
//  Created by YUNRUIMAC on 15/12/13.
//  Copyright © 2015年 YunRui. All rights reserved.
//

#import "StockViewController.h"
#import "ButtomView.h"
#import "Node.h"
#import "TreeTableView.h"
#import "ProductdetalViewController.h"
@interface StockViewController ()<TreeTableCellDelegate>
{
    NSString *parent;
    NSString *pparent;
    NSString *child;
    NSArray  *data1;
}
@end

@implementation StockViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 30)];
    view.backgroundColor=[UIColor lightGrayColor];
    UILabel *nameofpro=[[UILabel alloc]initWithFrame:CGRectMake(14, 0, ScreenWidth/3, 30)];
    nameofpro.text=@"产品名称";
    nameofpro.font=[UIFont fontWithName:@"ArialMT" size:14];
    [view addSubview:nameofpro];
    
    UILabel *count=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth/3, 30)];
    count.text=@"产品名称";
    count.font=[UIFont fontWithName:@"ArialMT" size:14];
    count.center=view.center;
    count.textAlignment=NSTextAlignmentCenter;
    [view addSubview:count];
    
    UIButton *mate=[[UIButton alloc]initWithFrame:CGRectMake(ScreenWidth-80, 0, 80, 30)];
    [mate setTitle:@"匹配客户" forState:UIControlStateNormal];
    mate.titleLabel.font=[UIFont fontWithName:@"ArialMT" size:14];
    mate.titleLabel.textAlignment=NSTextAlignmentCenter;
    [mate setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [mate addTarget:self action:@selector(Actiondo:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:mate];
    
    [self.view addSubview:view];
    [self initData];
    self.extendedLayoutIncludesOpaqueBars = NO;
    self.edgesForExtendedLayout = UIRectEdgeBottom | UIRectEdgeLeft | UIRectEdgeRight;
    self.navigationController.navigationBarHidden=NO;
    self.navigationItem.leftItemsSupplementBackButton=NO;
    ButtomView* BtmV=[[ButtomView alloc]initWithFrame:CGRectMake(0, ScreenHeight-114, ScreenWidth, 50)];
    [self.view addSubview:BtmV];
    // Do any additional setup after loading the view.
}
-(void)Actiondo:(id)sender
{
    [self performSegueWithIdentifier:@"need" sender:self];
}
-(void)initData{
    
    //----------------------------------中国的省地市关系图3,2,1--------------------------------------------
    Node *country1 = [[Node alloc] initWithParentId:-1 nodeId:0 name:@"中国" depth:0 expand:YES child:YES];
    Node *province1 = [[Node alloc] initWithParentId:0 nodeId:1 name:@"江苏" depth:1 expand:NO child:YES];
    Node *city1 = [[Node alloc] initWithParentId:1 nodeId:2 name:@"南通" depth:2 expand:NO child:NO];
    //Node *subCity1 = [[Node alloc] initWithParentId:2 nodeId:100 name:@"通州" depth:3 expand:NO];
    //Node *subCity2 = [[Node alloc] initWithParentId:2 nodeId:101 name:@"如东" depth:3 expand:NO];
    Node *city2 = [[Node alloc] initWithParentId:1 nodeId:3 name:@"南京" depth:2 expand:NO child:NO];
    Node *city3 = [[Node alloc] initWithParentId:1 nodeId:4 name:@"苏州" depth:2 expand:NO child:NO];
    Node *province2 = [[Node alloc] initWithParentId:0 nodeId:5 name:@"广东" depth:1 expand:NO child:YES];
    Node *city4 = [[Node alloc] initWithParentId:5 nodeId:6 name:@"深圳" depth:2 expand:NO child:NO];
    Node *city5 = [[Node alloc] initWithParentId:5 nodeId:7 name:@"广州" depth:2 expand:NO child:NO];
    Node *province3 = [[Node alloc] initWithParentId:0 nodeId:8 name:@"浙江" depth:1 expand:NO child:YES];
    Node *city6 = [[Node alloc] initWithParentId:8 nodeId:9 name:@"杭州" depth:2 expand:NO child:NO];
    //----------------------------------美国的省地市关系图0,1,2--------------------------------------------
    Node *country2 = [[Node alloc] initWithParentId:-1 nodeId:10 name:@"美国" depth:0 expand:YES child:YES];
    Node *province4 = [[Node alloc] initWithParentId:10 nodeId:11 name:@"纽约州" depth:1 expand:NO child:YES];
    Node *province5 = [[Node alloc] initWithParentId:10 nodeId:12 name:@"德州" depth:1 expand:NO child:YES];
    Node *city7 = [[Node alloc] initWithParentId:12 nodeId:13 name:@"休斯顿" depth:2 expand:NO child:NO];
    Node *province6 = [[Node alloc] initWithParentId:10 nodeId:14 name:@"加州" depth:1 expand:NO child:YES];
    Node *city8 = [[Node alloc] initWithParentId:14 nodeId:15 name:@"洛杉矶" depth:2 expand:NO child:NO];
    Node *city9 = [[Node alloc] initWithParentId:14 nodeId:16 name:@"旧金山" depth:2 expand:NO child:NO];
    
    //----------------------------------日本的省地市关系图0,1,2--------------------------------------------
    Node *country3 = [[Node alloc] initWithParentId:-1 nodeId:17 name:@"日本" depth:0 expand:YES child:YES];
    Node *province7 = [[Node alloc] initWithParentId:17 nodeId:18 name:@"东京" depth:1 expand:NO  child:NO];
    Node *province8 = [[Node alloc] initWithParentId:17 nodeId:19 name:@"东京1" depth:1 expand:NO child:NO];
    Node *province9 = [[Node alloc] initWithParentId:17 nodeId:20 name:@"东京2" depth:1 expand:NO child:NO];
    
    //后面数字可采用Node的写法 也可采用dictionary写 可能有点问题，到时再看
    //NSArray *data = [NSArray arrayWithObjects:country1,country2,country3, nil];
    
    //NSArray *data = [NSArray arrayWithObjects:country1,province1,province2,province3,country2,province4,province5,province6,country3, nil];
    
    NSArray *data = [NSArray arrayWithObjects:country1,province1,city1,city2,city3,province2,city4,city5,province3,city6,country2,province4,province5,city7,province6,city8,city9,country3,province7,province8,province9, nil];
    data1=[NSArray arrayWithArray:data];
    
    TreeTableView *tableview = [[TreeTableView alloc] initWithFrame:CGRectMake(0, 30, CGRectGetWidth(self.view.frame), self.view.frame.size.height-133) withData:data];
    tableview.treeTableCellDelegate = self;
    [self.view addSubview:tableview];
}

#pragma mark - TreeTableCellDelegate
-(void)cellClick:(Node *)node{
    NSLog(@"%@",node.name);
    if(node.depth==2)
    {
        for(Node *nd in data1)
        {
            if (nd.nodeId==node.parentId) {
                parent=nd.name;
                for (Node *ndd in data1) {
                    if (ndd.nodeId==nd.parentId) {
                        pparent=ndd.name;
                        child=node.name;
                    }
                }
            }
        }
    [self performSegueWithIdentifier:@"product" sender:self];
    }
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqual:@"product"]) {
        ProductdetalViewController *product=segue.destinationViewController;
        product.depth0=pparent;
        product.depth1=parent;
        product.depth2=child;
        
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
