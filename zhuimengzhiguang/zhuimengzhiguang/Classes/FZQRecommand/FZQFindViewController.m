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
  
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kUIScreenWidth, 44)];
    view.backgroundColor = [UIColor whiteColor];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake((kUIScreenWidth-20)/2, 10, (kUIScreenWidth-20)/2, 24)];
    label.text = @"说走就走的旅行";
    label.textAlignment = NSTextAlignmentCenter;
    [view addSubview:label];
    label.center = view.center;
    view.backgroundColor = [UIColor colorWithRed:104/255.0 green:185/255.0 blue:231/255.0 alpha:1];
   
 
    [scNTC.view addSubview:view];
    
    
}


-(void)viewWillAppear:(BOOL)animated{
    // 隐藏状态栏
    if ([self respondsToSelector:@selector(setNeedsStatusBarAppearanceUpdate)]) {
        [self prefersStatusBarHidden];
        [self performSelector:@selector(setNeedsStatusBarAppearanceUpdate)];
    }
}


- (BOOL)prefersStatusBarHidden
{
    return YES;//隐藏为YES，显示为NO
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
