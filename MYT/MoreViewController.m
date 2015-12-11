//
//  MoreViewController.m
//  MYT
//
//  Created by 熊凯 on 15/12/11.
//  Copyright © 2015年 YunRui. All rights reserved.
//

#import "MoreViewController.h"
#import "Utility.h"
@interface MoreViewController ()

@end

@implementation MoreViewController

-(void)viewWillAppear:(BOOL)animated
{
 [[Utility sharedInstance] setLayerView:_btnMore borderW:2 borderColor:[UIColor whiteColor] radius:40];
}

- (void)viewDidLoad {
   
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
