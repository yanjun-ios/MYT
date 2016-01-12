//
//  MyteamViewController.m
//  MYT
//
//  Created by YUNRUIMAC on 15/12/11.
//  Copyright © 2015年 YunRui. All rights reserved.
//

#import "MyteamViewController.h"
#import "ButtomView.h"
#import "Utility.h"
#import "KxMenu.h"
#import "NIDropDown.h"
#import "QuartzCore/QuartzCore.h"
#import "Y_NetRequestManager.h"
#import "PhoneTableViewController.h"
@interface MyteamViewController ()
{
    //Boolean mo,mt,yr;//判断是否点开
      NIDropDown *dropDown;
     __block NSDictionary* jsonDic;
}

@end

@implementation MyteamViewController
-(void)viewWillAppear:(BOOL)animated
{
    ButtomView* BtmV=[[ButtomView alloc]initWithFrame:CGRectMake(0, ScreenHeight-49, ScreenWidth, 50)];
    [self.view addSubview:BtmV];
    self.navigationController.navigationBarHidden=YES;
}
-(void)viewDidDisappear:(BOOL)animated
{
    self.navigationController.navigationBarHidden=NO;
}

- (void)viewDidLoad {
    _tableview1.delegate=self;
    _tableview1.dataSource=self;
  
    
    /*mo=0;//未打开
    mt=0;
    yr=0;*/
   
    self.extendedLayoutIncludesOpaqueBars = NO;
    self.edgesForExtendedLayout = UIRectEdgeBottom | UIRectEdgeLeft | UIRectEdgeRight;
    self.navigationController.navigationBarHidden=NO;
    self.navigationItem.leftItemsSupplementBackButton=NO;
    [self.navigationController.navigationBar setTitleTextAttributes:
     
     @{NSFontAttributeName:[UIFont systemFontOfSize:16],
       
       NSForegroundColorAttributeName:[UIColor whiteColor]}];
    if (currentVersion <= 6.1) {
        self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    } else {
        self.navigationController.navigationBar.barTintColor = [UIColor blackColor];
        self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
        CGRect statusRe = [[UIApplication sharedApplication] statusBarFrame];
        UIView* status=[[UIView alloc]initWithFrame:CGRectMake(0, -20, statusRe.size.width, statusRe.size.height)];
        status.backgroundColor=[UIColor whiteColor];
        [self.navigationController.navigationBar addSubview:status];
    }
    
    
    
    [[Utility sharedInstance] setLayerView:_monthone borderW:1 borderColor:[UIColor redColor] radius:5];
    [[Utility sharedInstance] setLayerView:_monthtwo borderW:1 borderColor:[UIColor redColor] radius:5];
    
    //navigationbar button 效果
    [_shi addTarget:self action:@selector(showMenu:) forControlEvents:UIControlEventTouchUpInside];
    [_Nabarbutton addTarget:self action:@selector(showMenu:) forControlEvents:UIControlEventTouchUpInside];
    [super viewDidLoad];
   
    // Do any additional setup after loading the view.
}

//下拉效果

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

//年月日下拉菜单的代理方法

- (void) niDropDownDelegateMethod: (NIDropDown *) sender {
    [self rel];
    NSString* selectedStr=sender.setcetedStr;
    UIButton* btn=sender.btnSender;
    NSString* firStr = _monthone.titleLabel.text;
    NSString* twostr =  _monthtwo.titleLabel.text;
    
    if (btn.tag==110) {
        //点击了年
    }else if(btn.tag==111)
    {
        //点击了第一个月份
        int begin_month=[selectedStr substringToIndex:(selectedStr.length-1)].intValue;
       int end_month= [twostr substringToIndex:(twostr.length-1)].intValue;
        if (begin_month>end_month) {
            //将结束月份的值改为与歧视月份相同
            [_monthtwo setTitle:selectedStr forState:UIControlStateNormal];
        }
    }else if(btn.tag==112)
    {
        //点击了第二个月
        int end_month=[selectedStr substringToIndex:(selectedStr.length-1)].intValue;
        int begin_month= [firStr substringToIndex:(firStr.length-1)].intValue;
        if (begin_month>end_month) {
            //将结束月份的值改为与歧视月份相同
            [_monthone setTitle:selectedStr forState:UIControlStateNormal];
        }

    }
}

-(void)rel{
    //    [dropDown release];
    dropDown = nil;
}
//右上角navigationbar button
- (void)showMenu:(UIButton *)sender
{
    NSArray *menuItems =
    @[
      
      [KxMenuItem menuItem:@"业绩排行"
                     image:[UIImage imageNamed:@"ok"]
                    target:self
                    action:@selector(performanceClick:)],
      
      [KxMenuItem menuItem:@"通讯录"
                     image:[UIImage imageNamed:@"ok"]
                    target:self
                    action:@selector(phone:)],
      
      ];
    
    KxMenuItem *first = menuItems[0];
    first.foreColor = [UIColor colorWithRed:47/255.0f green:112/255.0f blue:225/255.0f alpha:1.0];
    first.alignment = NSTextAlignmentCenter;
    
    [KxMenu showMenuInView:self.view
                  fromRect:sender.frame
                 menuItems:menuItems];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
        return 10;
   
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  
    static NSString* identifi=@"cell1";
    UITableViewCell* cell;
    cell=[_tableview1 dequeueReusableCellWithIdentifier:identifi];
    if(!cell)
    {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifi];
        
        //姓名
        UILabel* name=[[UILabel alloc]init];
        name.frame=CGRectMake(15, 12, 50, 20);
        name.font=[UIFont systemFontOfSize:16];
        name.textColor=[UIColor darkGrayColor];
        name.tag=1000;
        [cell.contentView addSubview:name];
        
        //业绩
        UIButton* gread=[[UIButton alloc]init];
        gread.frame=CGRectMake(0, 0, 50, 20);
        gread.center=CGPointMake(ScreenWidth/2, 22);
        gread.titleLabel.font=[UIFont systemFontOfSize:16];
        [gread setTitleColor:[UIColor orangeColor] forState:0];
        
        gread.tag=1001;
        [cell.contentView addSubview:gread];
        
        //跟及率
        UIButton* follow=[[UIButton alloc]init];
        follow.frame=CGRectMake(0, 0, 50, 20);
        follow.center=CGPointMake(ScreenWidth-48, 22);
        follow.titleLabel.font=[UIFont systemFontOfSize:16];
        [follow setTitleColor:[UIColor colorWithRed:66.0/255 green:143.0/255 blue:68.0/255 alpha:1.0] forState:0];
      
        follow.tag=1002;
        [cell.contentView addSubview:follow];
        
        int ismanager=[[[NSUserDefaults standardUserDefaults] objectForKey:@"profess_state"] intValue];
        if (ismanager==1) {
            //本人是经理，有权限看别人的业绩和跟及率
            [gread addTarget:self action:@selector(clickGread:) forControlEvents:UIControlEventTouchUpInside];
             [follow addTarget:self action:@selector(clickFollow:) forControlEvents:UIControlEventTouchUpInside];
        }
        
    }
    ((UILabel*)[cell.contentView viewWithTag:1000]).text=@"马云";
    
    UIButton* btnGread = (UIButton*)[cell.contentView viewWithTag:1001];
    btnGread.tag=10000+indexPath.row;
    [btnGread setTitle:@"0万" forState:0];
    
    UIButton* btnfollow = (UIButton*)[cell.contentView viewWithTag:1002];
    btnfollow.tag=20000+indexPath.row;
   [btnfollow setTitle:@"%80" forState:0];
//    UILabel* staffname= (UILabel*)[cell.contentView viewWithTag:1000];
//   int isManager =((NSNumber*)[[[jsonDic objectForKey:@"list"] objectAtIndex:[indexPath row]] objectForKey:@"lev"]).intValue;
//    if (isManager==1){
//        //经理的姓名为红色
//        staffname.textColor=[UIColor redColor];
//    }
//    staffname.text=[[[jsonDic objectForKey:@"list"] objectAtIndex:[indexPath row]] objectForKey:@"staffname"];
//    
//    UIButton* btnGread = (UIButton*)[cell.contentView viewWithTag:1001];
//    btnGread.tag=10000+indexPath.row;
//    [btnGread setTitle:[[[jsonDic objectForKey:@"list"] objectAtIndex:[indexPath row]] objectForKey:@"feat"] forState:0];
//    
//    UIButton* btnfollow = (UIButton*)[cell.contentView viewWithTag:1002];
//    btnfollow.tag=20000+indexPath.row;
//    [btnfollow setTitle:[[[jsonDic objectForKey:@"list"] objectAtIndex:[indexPath row]] objectForKey:@"rate"] forState:0];
        return cell;
 

}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
   
        return 1;
    

}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"adresslist"]) {
        PhoneTableViewController* destination=[segue destinationViewController];
        destination.getTeamDic=jsonDic;
    }
}
//点击右上角通讯录按钮
-(void)phone:(id)sender
{
    [self performSegueWithIdentifier:@"adresslist" sender:self];
}

////业绩排行按钮点击事件
//-(void)performanceClick:(UIButton*)btn
//{
//    [self performSegueWithIdentifier:@"performance" sender:nil];
//}
////跟机率点击事件
//- (IBAction)followcount_click:(id)sender {
//    [self performSegueWithIdentifier:@"follow" sender:self];
//}

////业绩排行按钮点击事件
-(void)clickGread:(UIButton*)btn
{
    [self performSegueWithIdentifier:@"performance" sender:nil];
}
////跟机率点击事件
-(void)clickFollow:(UIButton*)btn
{
    [self performSegueWithIdentifier:@"follow" sender:self];
}
- (IBAction)monthclickone:(id)sender {
    /* if (!mo) {
     _tableview2.hidden=NO;
     [_tableview2 reloadData];
     mo=1;
     }
     else
     {
     _tableview2.hidden=YES;
     mo=0;
     }*/
    NSArray * arr = [[NSArray alloc] init];
    arr = [NSArray arrayWithObjects:@"1月", @"2月", @"3月", @"4月", @"5月", @"6月", @"7月", @"8月", @"9月", @"10月",@"11月",@"12月",nil];
    //    NSArray * arrImage = [[NSArray alloc] init];
    //    arrImage = [NSArray arrayWithObjects:[UIImage imageNamed:@"apple.png"], [UIImage imageNamed:@"apple2.png"], [UIImage imageNamed:@"apple.png"], [UIImage imageNamed:@"apple2.png"], [UIImage imageNamed:@"apple.png"], [UIImage imageNamed:@"apple2.png"], [UIImage imageNamed:@"apple.png"], [UIImage imageNamed:@"apple2.png"], [UIImage imageNamed:@"apple.png"], [UIImage imageNamed:@"apple2.png"], nil];
    if(dropDown == nil) {
        CGFloat f = 200;
        dropDown = [[NIDropDown alloc]showDropDown:sender :&f :arr :nil :@"down"];
        dropDown.delegate = self;
    }
    else {
        [dropDown hideDropDown:sender];
        [self rel];
    }

}

- (IBAction)monthclicktwo:(id)sender {
    /*if (!mt) {
     _tableview3.hidden=NO;
     [_tableview3 reloadData];
     mt=1;
     }
     else
     {
     _tableview3.hidden=YES;
     mt=0;
     }*/
    NSArray * arr = [[NSArray alloc] init];
    arr = [NSArray arrayWithObjects:@"1月", @"2月", @"3月", @"4月", @"5月", @"6月", @"7月", @"8月", @"9月", @"10月",@"11月",@"12月",nil];
    //    NSArray * arrImage = [[NSArray alloc] init];
    //    arrImage = [NSArray arrayWithObjects:[UIImage imageNamed:@"apple.png"], [UIImage imageNamed:@"apple2.png"], [UIImage imageNamed:@"apple.png"], [UIImage imageNamed:@"apple2.png"], [UIImage imageNamed:@"apple.png"], [UIImage imageNamed:@"apple2.png"], [UIImage imageNamed:@"apple.png"], [UIImage imageNamed:@"apple2.png"], [UIImage imageNamed:@"apple.png"], [UIImage imageNamed:@"apple2.png"], nil];
    if(dropDown == nil) {
        CGFloat f = 200;
        dropDown = [[NIDropDown alloc]showDropDown:sender :&f :arr :nil :@"down"];
        dropDown.delegate = self;
    }
    else {
        [dropDown hideDropDown:sender];
        [self rel];
    }
}

- (IBAction)yearclick:(id)sender {
    /*   if (!yr) {
     _tableview4.hidden=NO;
     [_tableview4 reloadData];
     yr=1;
     }
     else
     {
     _tableview4.hidden=YES;
     yr=0;
     }*/
    NSArray * arr = [[NSArray alloc] init];
    arr = [NSArray arrayWithObjects:@"2015", @"2016", @"2017", @"2018", @"2019", @"2020",nil];
    //    NSArray * arrImage = [[NSArray alloc] init];
    //    arrImage = [NSArray arrayWithObjects:[UIImage imageNamed:@"apple.png"], [UIImage imageNamed:@"apple2.png"], [UIImage imageNamed:@"apple.png"], [UIImage imageNamed:@"apple2.png"], [UIImage imageNamed:@"apple.png"], [UIImage imageNamed:@"apple2.png"], [UIImage imageNamed:@"apple.png"], [UIImage imageNamed:@"apple2.png"], [UIImage imageNamed:@"apple.png"], [UIImage imageNamed:@"apple2.png"], nil];
    if(dropDown == nil) {
        CGFloat f = 200;
        dropDown = [[NIDropDown alloc]showDropDown:sender :&f :arr :nil :@"down"];
        dropDown.delegate = self;
    }
    else {
        [dropDown hideDropDown:sender];
           [self rel];
    }
}
- (IBAction)achievement_click:(id)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    UIViewController *myindent  = (UIViewController *)[storyboard instantiateViewControllerWithIdentifier:@"Myindent"];
    [self.navigationController pushViewController:myindent animated:YES];
}

- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)jidu1_click:(id)sender {
    
    int btntag = ((UIButton*)sender).tag;
    NSString* year=_year.titleLabel.text;
    NSString* firStr;
    NSString* twostr;
    switch (btntag) {
        case 501:
            //第一季度
            [_monthone setTitle:@"1月" forState:0];
           
            [_monthtwo setTitle:@"3月" forState:0];
             firStr=@"1";
            twostr=@"3";
            break;
        case 502:
            //第二季度
            [_monthone setTitle:@"4月" forState:0];
            [_monthtwo setTitle:@"6月" forState:0];
            firStr=@"4";
            twostr=@"6";
            break;
        case 503:
            //第三季度
            [_monthone setTitle:@"7月" forState:0];
            [_monthtwo setTitle:@"9月" forState:0];
            firStr=@"7";
            twostr=@"9";
            break;
        case 504:
            //第四季度
            [_monthone setTitle:@"10月" forState:0];
            [_monthtwo setTitle:@"12月" forState:0];
            firStr=@"10";
            twostr=@"12";
            break;
        default:
            break;
    }
    //点击季度按钮之后开始请求数据
    
    NSString* teamid = [[NSUserDefaults standardUserDefaults] objectForKey:@"dep_id"];
    NSString* userid=[[NSUserDefaults standardUserDefaults]objectForKey:@"user_id"];
    [self getteamDataByYear:year beginMonth:firStr endMonth:twostr teamId:teamid userId:userid];
//    NSDictionary*  jsondic =  [[Y_NetRequestManager sharedInstance] getteamDataByYear:year beginMonth:[firStr substringToIndex:(firStr.length-1)] endMonth:[twostr substringToIndex:(twostr.length-1)] teamId:teamid userId:userid];
//    if (jsondic) {
//        [_tableview1 reloadData];
//    }
}

-(void)getteamDataByYear:(NSString*)year beginMonth:(NSString*)bengin endMonth:(NSString*)end teamId:(NSString*)teamid userId:(NSString*)userid
{
    NSMutableDictionary* parDic=[[NSMutableDictionary alloc]initWithCapacity:10];
    [parDic setValue:year forKey:@"year"];
    [parDic setValue:bengin forKey:@"monthS"];
    [parDic setValue:end forKey:@"monthE"];
    [parDic setValue:teamid forKey:@"depId"];
    [parDic setValue:userid forKey:@"userid"];
    [[QQRequestManager sharedRequestManager] GET:[SEVER_URL stringByAppendingPathComponent:@"yd/getDepStaffList.action"] parameters:parDic showHUD:YES success:^(NSURLSessionDataTask *task, id responseObject) {
        jsonDic = (NSDictionary*)responseObject;
        [_tableview1 reloadData];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [self qq_performSVHUDBlock:^{
            [SVProgressHUD showErrorWithStatus:@"数据请求错误，请检查网络！"];
        }];

    }];
}


@end
