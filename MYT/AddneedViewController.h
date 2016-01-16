//
//  AddneedViewController.h
//  MYT
//
//  Created by YUNRUIMAC on 16/1/16.
//  Copyright © 2016年 YunRui. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddneedViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(nonatomic,assign)NSArray *nodearr;

@end
