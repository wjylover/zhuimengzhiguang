//
//  WJYHotCityViewController.m
//  zhuimengzhiguang
//
//  Created by 王建业 on 15/11/14.
//  Copyright © 2015年 王建业. All rights reserved.
//

#import "WJYHotCityViewController.h"
#import "HotContentViewController.h"
#import <MJRefresh.h>
#import "HomeCell.h"
#import "WJYDataManager.h"
#import "Hot.h"
#define kImageHight [UIScreen mainScreen].bounds.size.width / (490 / 285.0)


@interface WJYHotCityViewController ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>
@property (strong, nonatomic) IBOutlet UITableView *hotTanelView;
@property (nonatomic, strong) NSMutableArray *hotDataArray;
@end

@implementation WJYHotCityViewController
static NSInteger page = 1;


- (void)backAction:(UIBarButtonItem *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"热门城市";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back_arrow"] style:UIBarButtonItemStyleDone target:self action:@selector(backAction:)];
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor whiteColor];

    page = 1;
    [_hotDataArray removeAllObjects];
    
    [_hotTanelView registerNib:[UINib nibWithNibName:@"HomeCell" bundle:nil] forCellReuseIdentifier:@"homeCell"];
    _hotDataArray = [NSMutableArray arrayWithCapacity:20];
    self.hotTanelView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self loadData];
    }];
    [self.hotTanelView.mj_header beginRefreshing];
    [WJYDataManager sharedManager].homeHotBlock = ^(){
        [_hotDataArray addObjectsFromArray:[WJYDataManager sharedManager].homeHotDataArray];
        [self.hotTanelView reloadData];
        [self.hotTanelView.mj_header endRefreshing];
        [self.hotTanelView.mj_footer endRefreshing];
        if ([WJYDataManager sharedManager].homeHotDataArray.count == 0) {
            [self.hotTanelView.mj_footer endRefreshingWithNoMoreData];
        }
    };
    self.hotTanelView.mj_footer = [MJRefreshBackStateFooter footerWithRefreshingBlock:^{
        page++;
        [self loadData];
    }];
    self.hotTanelView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (void)loadData
{
    [[WJYDataManager sharedManager] getHomeHotDataArrayWithCityID:self.cityID Page:page];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.hotDataArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 200;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.hidesBottomBarWhenPushed = YES;
    HotContentViewController *hotContentVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"HotContent"];
    hotContentVC.hot = self.hotDataArray[indexPath.row];
    HomeCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    hotContentVC.headImageView = [[UIImageView alloc] initWithImage:cell.homeImage.image];
    hotContentVC.headImageView.frame = CGRectMake(0, -kImageHight, self.view.frame.size.width, kImageHight);
    [self showViewController:hotContentVC sender:nil];
    self.hidesBottomBarWhenPushed = NO;

}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HomeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"homeCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    Hot *hot = _hotDataArray[indexPath.row];
    
    [cell.homeImage sd_setImageWithURL:[NSURL URLWithString:hot.cover] placeholderImage:nil];
    cell.homeLabel.text = hot.title;
    
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // Get visible cells on table view.
    NSArray *visibleCells = [self.hotTanelView visibleCells];
    
    for (HomeCell *cell in visibleCells) {
        [cell cellOnTableView:self.hotTanelView didScrollOnView:self.view];
    }
}
//- (UIStatusBarStyle)preferredStatusBarStyle
//{
//    return UIStatusBarStyleLightContent;
//}
//- (void)viewDidAppear:(BOOL)animated
//{
//    [super viewDidAppear:animated];
//    [self scrollViewDidScroll:nil];
//}
@end
