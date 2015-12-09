//
//  XNTabBarController.m
//  CustomTabbar
//
//  Created by 熊凯 on 15/11/28.
//  Copyright © 2015年 YanJun. All rights reserved.
//

#import "XNTabBarController.h"
#import "XNTabBar.h"
@interface XNTabBarController ()<XNTabBarDelegate>

@end

@implementation XNTabBarController

-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden=YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"%s",__func__);
    NSLog(@"%@",self.view.subviews);//打印出所有的子视图，和其frame
    
    //1.删除现有的tabbar
    CGRect rect = self.tabBar.bounds;//因为是直接加载到自带的tabbar上面，所以用bounds来加，否则会加到下面去 看不见。
    
    //2.测试添加自己的视图
    XNTabBar* myView = [[XNTabBar alloc]init];
    myView.delegate=self;
    myView.frame=rect;
    myView.backgroundColor=[UIColor whiteColor];
    [self.tabBar addSubview:myView];//覆盖掉之前的tabbar
    
    //3.为视图控制器添加按钮
    for(int i=0;i<self.viewControllers.count;i++)
    {
        NSString* imgname =[NSString stringWithFormat:@"tabBar%d",i+1];
        NSString* imgnameSel =[NSString stringWithFormat:@"tabBarSel%d",i+1];
        UIImage* img = [UIImage imageNamed:imgname];
        UIImage *imgsel=[UIImage imageNamed:imgnameSel];
        [myView addButtonWithImage:img selectedImage:imgsel];
    }
    //在myView上面画一条线
    UIView* line = [[UIView alloc]initWithFrame:CGRectMake(0, 0, myView.frame.size.width, 1)];
    line.backgroundColor=[UIColor lightTextColor];
    [myView addSubview:line];
}


/*永远不要忘记设置代理*/
-(void)tabBar:(XNTabBar *)tabBar selectedFrom:(NSInteger)from to:(NSInteger)to
{
    self.selectedIndex=to;
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
