//
//  MateProjectViewController.m
//  MYT
//
//  Created by YUNRUIMAC on 15/12/8.
//  Copyright © 2015年 YunRui. All rights reserved.
//

#import "MateProjectViewController.h"
#import "Utility.h"
#import "ButtomView.h"
@interface MateProjectViewController ()

@end

@implementation MateProjectViewController

- (void)viewDidLoad {
    
    _tableview.delegate=self;
    _tableview.dataSource=self;
    [[Utility sharedInstance]setLayerView:_abandon borderW:1 borderColor:[UIColor colorWithRed:96.0f/255.0f green:56.0f/255.0f blue:17.0f/255.0f alpha:0.5] radius:5.0];
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
    
    ButtomView* BtmV=[[ButtomView alloc]initWithFrame:CGRectMake(0, ScreenHeight-114, ScreenWidth, 50)];
    [self.view addSubview:BtmV];
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell=[_tableview dequeueReusableCellWithIdentifier:@"cell"];
    return cell;
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
