//
//  ChooseNeedsViewController.m
//  MYT
//
//  Created by 熊凯 on 16/3/17.
//  Copyright © 2016年 YunRui. All rights reserved.
//

#import "ChooseNeedsViewController.h"

@interface ChooseNeedsViewController ()

@end

@implementation ChooseNeedsViewController

- (void)viewDidLoad {
    _tableview.delegate=self;
    _tableview.dataSource=self;
    _searchNeedsBar.delegate=self;
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* identif=@"cell";
    UITableViewCell* cell;
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identif];
    }
    
    return cell;
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
