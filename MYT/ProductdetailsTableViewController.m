//
//  ProductdetailsTableViewController.m
//  MYT
//
//  Created by YUNRUIMAC on 15/12/14.
//  Copyright © 2015年 YunRui. All rights reserved.
//

#import "ProductdetailsTableViewController.h"
#import "ButtomView.h"
@interface ProductdetailsTableViewController ()

@end

@implementation ProductdetailsTableViewController

- (void)viewDidLoad {
    ButtomView* BtmV=[[ButtomView alloc]initWithFrame:CGRectMake(0, ScreenHeight-114, ScreenWidth, 50)];
    [self.view addSubview:BtmV];
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

#pragma mark - Table view data source
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{return  61;}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, 60)];
    UIView *view1=[[UIView alloc]initWithFrame:CGRectMake(0, 0,  self.tableView.frame.size.width, 35)];
    UIView *view2=[[UIView alloc]initWithFrame:CGRectMake(0, 35,  self.tableView.frame.size.width, 25)];
    view2.backgroundColor=[UIColor lightGrayColor];
    
    UILabel *jibie=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, 35)];
    jibie.textColor=[UIColor orangeColor];
    jibie.text=[NSString stringWithFormat:@"%@>%@>%@",_depth0,_depth1,_depth2];
    jibie.font=[UIFont fontWithName:@"ArialMT" size:14];
    [view1 addSubview:jibie];
    
    UILabel *length=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, tableView.frame.size.width/3, 25)];
    length.textColor=[UIColor blackColor];
    length.text=@"长度";
    length.textAlignment=NSTextAlignmentCenter;
    length.font=[UIFont fontWithName:@"ArialMT" size:14];
    
    UILabel *from=[[UILabel alloc]initWithFrame:CGRectMake(tableView.frame.size.width/3, 0, tableView.frame.size.width/3, 25)];
    from.textColor=[UIColor blackColor];
    from.text=@"产地";
    from.textAlignment=NSTextAlignmentCenter;
    from.font=[UIFont fontWithName:@"ArialMT" size:14];

    
    UILabel *count=[[UILabel alloc]initWithFrame:CGRectMake(tableView.frame.size.width*2/3, 0, tableView.frame.size.width/3, 25)];
    count.textColor=[UIColor blackColor];
    count.textAlignment=NSTextAlignmentCenter;
    count.text=@"数量";
    count.font=[UIFont fontWithName:@"ArialMT" size:14];
 

    [view2 addSubview:length];
    [view2 addSubview:from];
    [view2 addSubview:count];
    
    [view addSubview:view1];
    [view addSubview:view2];
    return view;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return 10;
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
