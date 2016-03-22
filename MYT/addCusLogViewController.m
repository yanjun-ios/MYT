//
//  addCusLogViewController.m
//  MYT
//
//  Created by 熊凯 on 16/3/18.
//  Copyright © 2016年 YunRui. All rights reserved.
//

#import "addCusLogViewController.h"
#import "QQRequestManager.h"
@interface addCusLogViewController ()
{
    UIDatePicker *datepicker;
}
@end

@implementation addCusLogViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置背景颜色
    self.view.backgroundColor=[UIColor colorWithRed:240.0/255 green:240.0/255 blue:240.0/255 alpha:1.0];
    //添加一个时间选择器
    datepicker=[[UIDatePicker alloc]init];
    [datepicker addTarget:self action:@selector(datechenged:) forControlEvents:UIControlEventValueChanged];
    [datepicker setLocale:[NSLocale localeWithLocaleIdentifier:@"zh-CN"]];
    
    //设置只显示日期
    datepicker.datePickerMode=UIDatePickerModeDateAndTime;
    
    _TF_Time.inputView=datepicker;
    // Do any additional setup after loading the view.
    
    
    
    UIButton* btn=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    [btn addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
    [self.view insertSubview:btn atIndex:0];
}

-(void)addData
{
    NSMutableDictionary* parDic=[[NSMutableDictionary alloc]initWithCapacity:10];
    [parDic setValue:[[NSUserDefaults standardUserDefaults]objectForKey:@"user_id"] forKey:@"userid"];
    [parDic setValue:_cusId forKey:@"cusid"];
    [parDic setValue:_TF_People.text forKey:@"name"];
    [parDic setValue:_TF_Time.text forKey:@"time"];
    [[QQRequestManager sharedRequestManager]GET:[SEVER_URL stringByAppendingString:@""] parameters:parDic showHUD:YES success:^(NSURLSessionDataTask *task, id responseObject) {
        [self qq_performSVHUDBlock:^{
            [SVProgressHUD showSuccessWithStatus:[responseObject objectForKey:@"msg"]];
        }];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [self qq_performSVHUDBlock:^{
            [SVProgressHUD showSuccessWithStatus:@"添加失败！"];
        }];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)datechenged:(id)sender
{
    // 获取用户通过UIDatePicker设置的日期和时间
    NSDate *selected = [datepicker date];
    // 创建一个日期格式器
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    // 为日期格式器设置格式字符串
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    // 使用日期格式器格式化日期、时间
    NSString *destDateString = [dateFormatter stringFromDate:selected];
    
    _TF_Time.text=destDateString;
}

-(void)click
{
    [_TF_People resignFirstResponder];
    [_TF_Time resignFirstResponder];
   
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)click_Add:(id)sender {
    
    [self addData];
}
@end
