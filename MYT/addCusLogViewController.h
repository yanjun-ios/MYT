//
//  addCusLogViewController.h
//  MYT
//
//  Created by 熊凯 on 16/3/18.
//  Copyright © 2016年 YunRui. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface addCusLogViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *TF_Time;
@property(nonatomic,copy)NSString* cusId;
@property (weak, nonatomic) IBOutlet UITextField *TF_People;
@property (weak, nonatomic) IBOutlet UIButton *btnAdd;
- (IBAction)click_Add:(id)sender;
@end
