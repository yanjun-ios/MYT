//
//  ChangeinfoTableViewController.h
//  MYT
//
//  Created by YUNRUIMAC on 16/1/10.
//  Copyright © 2016年 YunRui. All rights reserved.
//

#import <UIKit/UIKit.h>
//放错地方了 应该在YJCrud
@interface ChangeinfoTableViewController : UITableViewController<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *TF_name;
@property (weak, nonatomic) IBOutlet UITextField *TF_singlename;
@property (weak, nonatomic) IBOutlet UITextField *TF_phone;
@property (weak, nonatomic) IBOutlet UITextField *TF_need;
@property (weak, nonatomic) IBOutlet UITextField *TF_ChuanZ;
@property (weak, nonatomic) IBOutlet UITextField *TF_Website;

@end
