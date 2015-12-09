//
//  MateProjectViewController.h
//  MYT
//
//  Created by YUNRUIMAC on 15/12/8.
//  Copyright © 2015年 YunRui. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MateProjectViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UIButton *abandon;
@property (weak, nonatomic) IBOutlet UITableView *tableview;

@end
