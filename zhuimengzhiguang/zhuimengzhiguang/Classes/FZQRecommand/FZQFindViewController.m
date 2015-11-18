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
    recommandTVC.title = @"";
    
    //创建导航栏视图控制器
    SCNavTabBarController *scNTC = [[SCNavTabBarController alloc] initWithSubViewControllers:@[recommandTVC]];
    scNTC.scrollAnimation = YES;
    scNTC.mainViewBounces = YES;
    [scNTC addParentController:self];
  
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kUIScreenWidth, 64)];
    view.backgroundColor = [UIColor whiteColor];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 30, kUIScreenWidth, 24)];
    label.text = @"说走就走的旅行";
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont fontWithName:@"Helvetica-Bold" size:17];
    [view addSubview:label];
    view.backgroundColor =  [UIColor colorWithRed:0.313 green:0.782 blue:1.000 alpha:1.000];   
    [scNTC.view addSubview:view];
    
    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
