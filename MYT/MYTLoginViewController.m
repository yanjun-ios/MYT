//
//  MYTLoginViewController.m
//  MYT
//
//  Created by 熊凯 on 15/12/7.
//  Copyright © 2015年 YunRui. All rights reserved.
//

#import "MYTLoginViewController.h"
#import "Utility.h"
#import "QQRequestManager.h"
#import "UIViewController+Helper.h"
#import "IIViewDeckController.h"
#import <SVProgressHUD.h>
@interface MYTLoginViewController ()

@end

@implementation MYTLoginViewController

-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden=YES;
    _layCon.constant=160;
    _btnLogin.alpha=0.0f;
    _ViewForm.alpha=0.0f;
    [UIView animateWithDuration:2.0f animations:^{
        _layCon.constant=40;
        _btnLogin.alpha=1.0f;
        _ViewForm.alpha=1.0f;
    }];
    
    
}

- (void)viewDidLoad {
    //取消侧拉
    [self.viewDeckController setPanningMode:IIViewDeckNoPanning];
    
    [[Utility sharedInstance] setLayerView:_ViewForm borderW:1 borderColor:[UIColor lightGrayColor] radius:3];
    _TF_UserName.delegate=self;
    _TF_Password.delegate=self;
    if([[NSUserDefaults standardUserDefaults]objectForKey:@"username"])
    {
        _TF_UserName.text=[[NSUserDefaults standardUserDefaults]objectForKey:@"username"];
    }
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [_TF_UserName resignFirstResponder];
    [_TF_Password resignFirstResponder];
    return YES;
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

- (IBAction)loginInto:(id)sender {
    [self performSegueWithIdentifier:@"mainPage" sender:nil];
    [_TF_UserName resignFirstResponder];
    [_TF_Password resignFirstResponder];
    NSMutableDictionary* parDic=[[NSMutableDictionary alloc]initWithCapacity:10];
    [parDic setValue:_TF_UserName.text forKey:@"username"];
    [parDic setValue:_TF_Password forKey:@"password"];
    [[QQRequestManager sharedRequestManager] GET:@"" parameters:parDic showHUD:YES success:^(NSURLSessionDataTask *task, id responseObject) {
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        
        [self qq_performSVHUDBlock:^{
            [SVProgressHUD showErrorWithStatus:@"登陆失败！"];
        }];
    }];
}
@end
