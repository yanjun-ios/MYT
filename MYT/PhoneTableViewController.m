//
//  PhoneTableViewController.m
//  MYT
//
//  Created by YUNRUIMAC on 15/12/12.
//  Copyright © 2015年 YunRui. All rights reserved.
//

#import "PhoneTableViewController.h"
#import "XNTabBarController.h"
@interface PhoneTableViewController ()

@end

@implementation PhoneTableViewController

- (void)viewDidLoad {
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
-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden=NO;
}
#pragma mark - Table view data source


// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* identifi=@"cell1";
    UITableViewCell* cell;
    cell=[self.tableView dequeueReusableCellWithIdentifier:identifi];
    if(!cell)
    {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifi];
        
        //姓名
        UILabel* name=[[UILabel alloc]init];
        name.frame=CGRectMake(15, 12, 50, 20);
        name.font=[UIFont systemFontOfSize:18];
        name.textColor=[UIColor darkGrayColor];
        name.tag=1000;
        [cell.contentView addSubview:name];
        
        //电话
        UILabel* phoneNumber=[[UILabel alloc]init];
        phoneNumber.frame=CGRectMake(0, 0, 200, 20);
        phoneNumber.center=CGPointMake(ScreenWidth/2, 22);
        phoneNumber.font=[UIFont systemFontOfSize:18];
        phoneNumber.textColor=[UIColor darkGrayColor];
        phoneNumber.tag=1001;
        [cell.contentView addSubview:phoneNumber];
        
        //电话
        UIButton* phone=[[UIButton alloc]init];
        phone.frame=CGRectMake(0, 0, 30, 30);
        phone.center=CGPointMake(ScreenWidth-35, 22);
        [phone setImage:[UIImage imageNamed:@"phone"] forState:0];
        [phone addTarget:self action:@selector(clickPhoneNumber:) forControlEvents:UIControlEventTouchUpInside];
        phone.tag=1002;
        [cell.contentView addSubview:phone];
    }

        UILabel* staffname= (UILabel*)[cell.contentView viewWithTag:1000];
       int isManager =((NSNumber*)[[[_getTeamDic objectForKey:@"list"] objectAtIndex:[indexPath row]] objectForKey:@"lev"]).intValue;
        if (isManager==1){
            //经理的姓名为红色
            staffname.textColor=[UIColor redColor];
        }
        staffname.text=[[[_getTeamDic objectForKey:@"list"] objectAtIndex:[indexPath row]] objectForKey:@"staffname"];
    
        UILabel* number = (UILabel*)[cell.contentView viewWithTag:1001];
    NSString* hisphoneNumber=[[[_getTeamDic objectForKey:@"list"] objectAtIndex:[indexPath row]] objectForKey:@"mobilephone"];
     number.text=hisphoneNumber;
        UIButton* btnfollow = (UIButton*)[cell.contentView viewWithTag:1002];
        btnfollow.tag=[hisphoneNumber intValue];
    

    
    return cell;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
      return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    //return [[_getTeamDic objectForKey:@"list"] count];
    return 10;
}


//点击打电话按钮拨打电话
-(void)clickPhoneNumber:(UIButton*)btn
{
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)addphone:(id)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
   
    XNTabBarController *tabbat=(XNTabBarController *)[storyboard instantiateViewControllerWithIdentifier:@"tabbar"];
    tabbat.index=2;
    [self.navigationController pushViewController:tabbat animated:YES];
}

@end
