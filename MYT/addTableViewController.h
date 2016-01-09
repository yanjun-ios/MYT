//
//  addTableViewController.h
//  MYT
//
//  Created by 熊凯 on 15/12/8.
//  Copyright © 2015年 YunRui. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface addTableViewController : UITableViewController<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *TF_CusName;
@property (weak, nonatomic) IBOutlet UITextField *TF_CusTtName;
@property (weak, nonatomic) IBOutlet UITextField *TF_MobilePhone;
@property (weak, nonatomic) IBOutlet UITextField *TF_CusCode;
- (IBAction)Click_GetLocation:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *TF_Phone;
@property (weak, nonatomic) IBOutlet UITextField *TF_website;
@property (weak, nonatomic) IBOutlet UIButton *btn_qiye;
- (IBAction)click_qiye:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *btn_person;
- (IBAction)click_person:(id)sender;
@end
