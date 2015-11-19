//
//  AboutCityViewController.m
//  zhuimengzhiguang
//
//  Created by lanou3g on 15/11/17.
//  Copyright © 2015年 王建业. All rights reserved.
//

#import "AboutCityViewController.h"
#import "GoodLocalTableViewController.h"
#import "FreeTableViewController.h"



@interface AboutCityViewController ()
@property (nonatomic,strong) GoodLocalTableViewController *goodTableView;
@property (nonatomic, strong) FreeTableViewController *freeTableView;

@property (weak, nonatomic) IBOutlet UISegmentedControl *segment;

@end

@implementation AboutCityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //布局tableView
    [self layoutSubViews];
    
    //添加segment事件
    [self.segment addTarget:self action:@selector(layourSegment:) forControlEvents:(UIControlEventValueChanged)];
}
//布局
-(void)layoutSubViews
{
    //创建并添加视图
    self.freeTableView = [[FreeTableViewController alloc]init];
    self.freeTableView.view.frame = CGRectMake(0, 95, self.view.bounds.size.width, self.view.bounds.size.height - 130);
    [self.view addSubview:self.freeTableView.view];

    
    //创建并添加视图
    self.goodTableView = [[GoodLocalTableViewController alloc]init];
    self.goodTableView.view.frame = CGRectMake(0, 95, self.view.bounds.size.width, self.view.bounds.size.height - 130);
    [self.view addSubview:_goodTableView.view];
    
    //默认的选择
    [self.view bringSubviewToFront:_freeTableView.view];
    
}
//布局segment
-(void)layourSegment:(UISegmentedControl *)segement
{
    if (segement.selectedSegmentIndex == 0 ) {
        //如果选择的是下坐标为0的  就把tableView放在最上面
        [self.freeTableView.tableView reloadData];
        [self.view bringSubviewToFront:self.freeTableView.view];
        
    }else{
        
        [self.goodTableView.tableView reloadData];
        [self.view bringSubviewToFront:_goodTableView.view];
        
    }
}


@end
