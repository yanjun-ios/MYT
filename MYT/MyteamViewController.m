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
@interface MyteamViewController ()
{
    //Boolean mo,mt,yr;//判断是否点开
      NIDropDown *dropDown;
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
- (void) niDropDownDelegateMethod: (NIDropDown *) sender {
    [self rel];
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
-(void)phone:(id)sender
{
    [self performSegueWithIdentifier:@"adresslist" sender:self];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
        return 10;
   
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  
        UITableViewCell *cell4=[_tableview1 dequeueReusableCellWithIdentifier:@"cell"];
        return cell4;
 

}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
   
        return 1;
    

}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

//业绩排行按钮点击事件
-(void)performanceClick:(UIButton*)btn
{
    [self performSegueWithIdentifier:@"performance" sender:nil];
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

- (IBAction)followcount_click:(id)sender {
    [self performSegueWithIdentifier:@"follow" sender:self];
}
- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
