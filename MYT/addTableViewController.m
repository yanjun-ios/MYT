//
//  addTableViewController.m
//  MYT
//
//  Created by 熊凯 on 15/12/8.
//  Copyright © 2015年 YunRui. All rights reserved.
//

#import "addTableViewController.h"

@interface addTableViewController ()
{
    UIButton* btnSelected;
}
@end

@implementation addTableViewController

//-(UIStatusBarStyle)preferredStatusBarStyle
//{
//    return UIStatusBarStyleLightContent;
//}

-(void)viewWillAppear:(BOOL)animated
{

    if(currentVersion>=7)
    {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }

}

- (void)viewDidLoad {
    //消除多余空白行
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    [self.tableView setTableFooterView:view];
    //设置背景颜色
    self.tableView.backgroundColor=[UIColor groupTableViewBackgroundColor];
    
    //设置各个输入框代理方法
    _TF_CusCode.delegate=self;
    _TF_CusName.delegate=self;
    _TF_CusTtName.delegate=self;
    _TF_MobilePhone.delegate=self;
    _TF_Phone.delegate=self;
    _TF_website.delegate=self;
    
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)Click_GetLocation:(id)sender {
}
- (IBAction)click_qiye:(id)sender {
    btnSelected.selected=NO;
    _btn_qiye.selected=YES;
    btnSelected=_btn_qiye;
}
- (IBAction)click_person:(id)sender {
    btnSelected.selected=NO;
    _btn_person.selected=YES;
    btnSelected=_btn_person;
}
@end
