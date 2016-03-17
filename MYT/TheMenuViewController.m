//
//  TheMenuViewController.m
//  MYT
//
//  Created by 熊凯 on 16/1/18.
//  Copyright © 2016年 YunRui. All rights reserved.
//

#import "TheMenuViewController.h"
#import "Utility.h"
#import "IIViewDeckController.h"
#import "ProvinceTableViewController.h"
#import "NetRequestManager.h"
#import "CilentViewController.h"
@interface TheMenuViewController ()
{
    NSMutableDictionary* locationCodeDic;
    NSMutableArray* clienttneedsArry;
}

@end

@implementation TheMenuViewController

- (void)viewDidLoad {
    _searchClient.delegate=self;
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

//点击跳转到区域选择界面
- (IBAction)clickLocation:(id)sender {
        [self.viewDeckController closeRightViewBouncing:^(IIViewDeckController *controller) {
            [NetRequestManager sharedInstance].FROMDECK=1;
            UINavigationController * navVC = (UINavigationController *) self.viewDeckController.centerController;
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            UITableViewController *ProvinceContro= (UITableViewController *)[storyboard instantiateViewControllerWithIdentifier:@"Province"];
            [navVC pushViewController:ProvinceContro animated:YES];
    
        }];

}
//点击跳转到用料需求选择界面
- (IBAction)clickToNeeds:(id)sender {
    
}



-(void)passLovation:(NSDictionary *)locationDic
{
   locationCodeDic = [[NSMutableDictionary alloc]initWithDictionary:locationDic];
    _labLocation.text=[NSString stringWithFormat:@"%@%@%@",[locationCodeDic objectForKey:@"provinceName"],[locationCodeDic objectForKey:@"cityName"],[locationCodeDic objectForKey:@"regionName"]];
}
- (IBAction)clickRemoveLocation:(id)sender {
    _labLocation.text=@"请选择区域";
    locationCodeDic=[[NSMutableDictionary alloc]initWithObjects:@[@"",@"",@"",@"",@"",@""] forKeys:@[@"cityCode",@"cityName",@"provinceCode",@"provinceName",@"regionCode",@"regionName"]];
}

- (IBAction)clickRemoveNeeds:(id)sender {
    
    
}
- (IBAction)filterNow:(id)sender {
    
    [self.viewDeckController closeRightViewBouncing:^(IIViewDeckController *controller) {
        [NetRequestManager sharedInstance].FROMDECK=1;
        CilentViewController *clientContro = [[CilentViewController alloc] init];
        CilentViewController *target = nil;
        UINavigationController * navVC = (UINavigationController *) self.viewDeckController.centerController;
        for (UIViewController * controller in navVC.viewControllers) { //遍历
            if ([controller isKindOfClass:[clientContro class]]) { //这里判断是否为你想要跳转的页面
                
                target = (CilentViewController*)controller;
            }
        }
        if (target) {
            self.searchDelegate=target;
            [self.searchDelegate passClientName:_searchClient.text Location:locationCodeDic Needs:clienttneedsArry];
            [navVC popToViewController:target animated:YES]; //跳转
        }
     
     }];

}
@end
