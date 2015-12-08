//
//  rightMenuViewController.h
//  MYT
//
//  Created by 熊凯 on 15/12/8.
//  Copyright © 2015年 YunRui. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface rightMenuViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *btnClear;
- (IBAction)clearClick:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *view_one;
@property (weak, nonatomic) IBOutlet UIView *view_two;

@property (weak, nonatomic) IBOutlet UIView *view_three;
@property (weak, nonatomic) IBOutlet UIView *view_four;
@end
