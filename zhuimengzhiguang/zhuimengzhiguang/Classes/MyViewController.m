//
//  MyViewController.m
//  zhuimengzhiguang
//
//  Created by lanou3g on 15/11/13.
//  Copyright © 2015年 王建业. All rights reserved.
//

#import "MyViewController.h"

@interface MyViewController ()

//创建一个放置所有按钮的视图
@property(nonatomic,strong)CHTumblrMenuView *tumblrMenuView;


@end

@implementation MyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
       
    
}

//点击按钮,出现所有点击按钮
- (IBAction)MenuAction:(UIButton *)sender {
    
    _tumblrMenuView = [[CHTumblrMenuView alloc]init];
    
    _tumblrMenuView.backgroundColor = [UIColor colorWithRed:46/255.0 green:62/255.0 blue:82/255.0 alpha:0.5];

    
    [_tumblrMenuView addMenuItemWithTitle:@"我的收藏" andIcon:[UIImage imageNamed:@"fff.jpg"] andSelectedBlock:^{
        NSLog(@"dddddd");
    }];
    
    [_tumblrMenuView addMenuItemWithTitle:@"Photo" andIcon:[UIImage imageNamed:@"fff.jpg"]  andSelectedBlock:^{
        NSLog(@"Photo selected");
    }];
    [_tumblrMenuView addMenuItemWithTitle:@"Quote" andIcon:[UIImage imageNamed:@"fff.jpg"]  andSelectedBlock:^{
        NSLog(@"Quote selected");
        
    }];
    [_tumblrMenuView addMenuItemWithTitle:@"Link" andIcon:[UIImage imageNamed:@"fff.jpg"]  andSelectedBlock:^{
        NSLog(@"Link selected");
        
    }];
    [_tumblrMenuView addMenuItemWithTitle:@"Chat" andIcon:[UIImage imageNamed:@"fff.jpg"]  andSelectedBlock:^{
        NSLog(@"Chat selected");
        
    }];
    
    [_tumblrMenuView show];
    
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
