//
//  CilentViewController.m
//  MYT
//
//  Created by 熊凯 on 15/12/8.
//  Copyright © 2015年 YunRui. All rights reserved.
//

#import "CilentViewController.h"
#import "XNTabBarController.h"
@interface CilentViewController ()
{
    BOOL addContact;
}
@end

@implementation CilentViewController

-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden=NO;
    
}

- (void)viewDidLoad {
    
    _tableview.delegate=self;
    _tableview.dataSource=self;
    _tableview.sectionFooterHeight=0;
    _tableview.sectionHeaderHeight=10;
    _tableview.rowHeight=UITableViewAutomaticDimension;
    _tableview.estimatedRowHeight=44.0;//这个必须加上，否则出现高度无法自适应问题。
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - tableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 6;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString* identif=@"cell";
    UITableViewCell* cell=[_tableview dequeueReusableCellWithIdentifier:identif];
    UIButton* btnadd=[[UIButton alloc]initWithFrame:CGRectMake(ScreenWidth-40, 60, 30, 30)];
    
    [btnadd setImage:[UIImage imageNamed:@"add"] forState:UIControlStateNormal];
    [cell.contentView addSubview:btnadd];
    [btnadd addTarget:self action:@selector(addContactsClick:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 15;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0;
}


-(void)addContactsClick:(id)sender
{
    [self performSegueWithIdentifier:@"toTab" sender:nil];
    addContact=YES;
}


#pragma mark - Navigation
//
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"toTab"])
    {
        XNTabBarController* destinationController=segue.destinationViewController;
        destinationController.isAddContact=addContact;
        
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
