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
#import "ChooseNeedsViewController.h"
@interface TheMenuViewController ()
{
    NSMutableDictionary* locationCodeDic;
    NSMutableArray* clienttneedsArry;
}

@end

@implementation TheMenuViewController

- (void)viewDidLoad {
    _searchClient.delegate=self;
    clienttneedsArry=[[NSMutableArray alloc]init];
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
    [self.viewDeckController closeRightViewBouncing:^(IIViewDeckController *controller) {
        [NetRequestManager sharedInstance].FROMDECK=1;
        UINavigationController * navVC = (UINavigationController *) self.viewDeckController.centerController;
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        UIViewController *NeedsContro= (UIViewController *)[storyboard instantiateViewControllerWithIdentifier:@"NEEDS"];
        [navVC pushViewController:NeedsContro animated:YES];
        
    }];
}

//选择用料需求的代理方法
-(void)passNeeds:(NSArray*)NeedsAry
{
    _labNeeds.textColor=[UIColor whiteColor];
    _labNeeds.text=@"您已选择用料需求";
    [clienttneedsArry addObjectsFromArray:NeedsAry];
}

//选择区域的代理方法
-(void)passLovation:(NSDictionary *)locationDic
{
   locationCodeDic = [[NSMutableDictionary alloc]initWithDictionary:locationDic];
    _labLocation.textColor=[UIColor whiteColor];
    _labLocation.text=[NSString stringWithFormat:@"%@%@%@",[locationCodeDic objectForKey:@"provinceName"],[locationCodeDic objectForKey:@"cityName"],[locationCodeDic objectForKey:@"regionName"]];
}

//清除区域选择
- (IBAction)clickRemoveLocation:(id)sender {
    _labLocation.text=@"请选择区域";
     _labLocation.textColor=[UIColor redColor];
    locationCodeDic=[[NSMutableDictionary alloc]initWithObjects:@[@"",@"",@"",@"",@"",@""] forKeys:@[@"cityCode",@"cityName",@"provinceCode",@"provinceName",@"regionCode",@"regionName"]];
}
//清除用料需求
- (IBAction)clickRemoveNeeds:(id)sender {
    
    _labNeeds.textColor=[UIColor redColor];
    _labNeeds.text=@"请选择用料需求";
    [clienttneedsArry removeAllObjects];
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
