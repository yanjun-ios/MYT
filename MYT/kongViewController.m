//
//  kongViewController.m
//  MYT
//
//  Created by 熊凯 on 15/12/8.
//  Copyright © 2015年 YunRui. All rights reserved.
//

#import "kongViewController.h"

@interface kongViewController ()

@end

@implementation kongViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    UINavigationController *centerNav  = (UINavigationController *)[storyboard instantiateViewControllerWithIdentifier:@"centerNav"];
    UINavigationController *rightNav= (UINavigationController *)[storyboard instantiateViewControllerWithIdentifier:@"rightNav"];
    
    _containerController = [[IIViewDeckController alloc]initWithCenterViewController:centerNav rightViewController:rightNav];
    _containerController.rightSize=ScreenWidth/4;
    _containerController.view.frame = self.view.bounds;
    [self.view addSubview:_containerController.view];
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
