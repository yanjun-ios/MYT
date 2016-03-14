//
//  messageDetailViewController.m
//  MYT
//
//  Created by 熊凯 on 16/1/14.
//  Copyright © 2016年 YunRui. All rights reserved.
//

#import "messageDetailViewController.h"
#import "Utility.h"
@interface messageDetailViewController ()

@end

@implementation messageDetailViewController

- (void)viewDidLoad {
    self.view.backgroundColor=[UIColor colorWithRed:230.0/255 green:230.0/255 blue:230.0/255 alpha:1.0];
    [[Utility sharedInstance] setLayerView:_TF_show borderW:1 borderColor:[UIColor lightGrayColor] radius:10];
    _TF_show.backgroundColor=[UIColor whiteColor];
    _labTitle.text=_getMessageType;
    _TF_show.text=_getMessageDetail;
    _lab_time.text=_getMessageTime;
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
