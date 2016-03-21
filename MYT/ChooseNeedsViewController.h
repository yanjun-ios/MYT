//
//  ChooseNeedsViewController.h
//  MYT
//
//  Created by 熊凯 on 16/3/17.
//  Copyright © 2016年 YunRui. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol PassNeedsArryDelegate
-(void)passNeeds:(NSArray*)NeedsAry;
@end
@interface ChooseNeedsViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>
@property (weak, nonatomic) IBOutlet UISearchBar *searchNeedsBar;
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraint_top;
- (IBAction)finishedChoosed:(id)sender;
@property(nonatomic,weak)id<PassNeedsArryDelegate> passneesdelegat;
@property(nonatomic,readonly) UIAccelerationValue oldOffset;
@end
