//
//  rightMenuViewController.m
//  MYT
//
//  Created by 熊凯 on 15/12/8.
//  Copyright © 2015年 YunRui. All rights reserved.
//

#import "rightMenuViewController.h"
#import "Utility.h"
@interface rightMenuViewController ()

@end

@implementation rightMenuViewController

- (void)viewDidLoad {
     [[Utility sharedInstance] setLayerView:_btnClear borderW:1 borderColor:[UIColor whiteColor] radius:3];
    [[Utility sharedInstance] setLayerView:_view_one borderW:0 borderColor:[UIColor clearColor] radius:3];
     [[Utility sharedInstance] setLayerView:_view_two borderW:0 borderColor:[UIColor clearColor] radius:3];
     [[Utility sharedInstance] setLayerView:_view_three borderW:0 borderColor:[UIColor clearColor] radius:3];
     [[Utility sharedInstance] setLayerView:_view_four borderW:0 borderColor:[UIColor clearColor] radius:3];
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

- (IBAction)clearClick:(id)sender {
}
@end
