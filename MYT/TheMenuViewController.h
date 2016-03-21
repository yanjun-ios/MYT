//
//  TheMenuViewController.h
//  MYT
//
//  Created by 熊凯 on 16/1/18.
//  Copyright © 2016年 YunRui. All rights reserved.
//
#import "RegionsTableViewController.h"
#import "ChooseNeedsViewController.h"
#import <UIKit/UIKit.h>

@protocol SearchClientParaDelegat <NSObject>

-(void)passClientName:(NSString*)text Location:(NSDictionary*)LocaDic Needs:(NSArray*)needArry;

@end

@interface TheMenuViewController : UIViewController<UISearchBarDelegate,PassLocationValueDelegate,PassNeedsArryDelegate>
- (IBAction)clickLocation:(id)sender;
- (IBAction)clickToNeeds:(id)sender;
@property (weak, nonatomic) IBOutlet UISearchBar *searchClient;
@property (weak, nonatomic) IBOutlet UILabel *labLocation;
- (IBAction)clickRemoveLocation:(id)sender;
- (IBAction)clickRemoveNeeds:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *labNeeds;
@property(nonatomic,weak) id<SearchClientParaDelegat>searchDelegate;
- (IBAction)filterNow:(id)sender;
@end
