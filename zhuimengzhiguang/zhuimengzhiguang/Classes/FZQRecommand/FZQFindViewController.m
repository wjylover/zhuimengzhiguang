//
//  FZQFindViewController.m
//  zhuimengzhiguang
//
//  Created by lanou3g on 15/11/9.
//  Copyright © 2015年 王建业. All rights reserved.
//

#import "FZQFindViewController.h"

@interface FZQFindViewController ()

@end

@implementation FZQFindViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
    
    //创建导航栏的视图控制器
    
    //推荐视图控制器
    FZQRecommandTableViewController *recommandTVC = [[FZQRecommandTableViewController alloc] init];
    recommandTVC.title = @"推荐";
    
    //创建导航栏视图控制器
    SCNavTabBarController *scNTC = [[SCNavTabBarController alloc] initWithSubViewControllers:@[recommandTVC]];
    //scNTC.navTabBarColor = [UIColor colorWithRed:41/255.0 green:158/255.0 blue:206/255.0 alpha:1.0];
    scNTC.view.frame = CGRectMake(0, 20, kUIScreenWidth, kUIScreenHeight-20) ;
    scNTC.scrollAnimation = YES;
    scNTC.mainViewBounces = YES;
    scNTC.navTabBarLineColor = [UIColor redColor];
    [scNTC addParentController:self];
  
  
    
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
