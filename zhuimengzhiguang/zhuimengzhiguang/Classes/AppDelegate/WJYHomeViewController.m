//
//  WJYHomeViewController.m
//  zhuimengzhiguang
//
//  Created by 王建业 on 15/11/9.
//  Copyright © 2015年 王建业. All rights reserved.
//

#import "WJYHomeViewController.h"
#import "HotContentViewController.h"
#import "WJYHotCityViewController.h"
#import "WJYScenerySpotViewController.h"
#import "ScenerySpotContent.h"
#import "ScenerySpot.h"
#import "WJYCityViewController.h"
#import "Hot.h"
#import "City.h"
#import "HomeCell.h"
#import "WJYDataManager.h"
#import "HotCity.h"
#import <UIImageView+WebCache.h>
#import <SDCycleScrollView.h>
#import <MJRefresh.h>

#define kImageHight [UIScreen mainScreen].bounds.size.width / (490 / 285.0)

@interface WJYHomeViewController ()<SDCycleScrollViewDelegate,UITableViewDataSource,UITableViewDelegate>
// 轮播图控件
@property (weak, nonatomic) IBOutlet SDCycleScrollView *cycleScrollView;
// 轮播图数据数组
@property (nonatomic, strong) NSArray *carouselImageArray;
@property (nonatomic, strong) NSArray *carouselTextArray;
@property (nonatomic, strong) NSMutableArray *cityListArray;
// 热门城市数据
@property (nonatomic, strong) NSMutableArray *homeHotArray;
// 普通城市景点数据
@property (nonatomic, strong) NSMutableArray *scenicSpotArray;

@property (nonatomic, strong) NSArray *hotCityIDArray;

@property (weak, nonatomic) IBOutlet UITableView *homeTableview;

// 当前位置的城市名
@property (nonatomic, strong) NSString *city;
// 当前当前位置的城市ID
@property (nonatomic, assign) NSInteger cityID;

@end

@implementation WJYHomeViewController


- (void)viewWillAppear:(BOOL)animated
{
    // 获取城市列表的回调(调用在定位当前位置方法中)
    [WJYDataManager sharedManager].cityBlock = ^(){
        self.cityListArray = [WJYDataManager sharedManager].cityListArray;
        
        for (City *city in _cityListArray) {
            if ([_city hasPrefix:city.city_name]) {
                _cityID = city.city_id;
                break;
            }
        }
        _scenicSpotArray = [NSMutableArray arrayWithCapacity:20];
        
        [[WJYDataManager sharedManager] getScenicSpotDataArrayWithCityID:_cityID];
        
        [WJYDataManager sharedManager].scenerySpotBlock = ^(){
        [_scenicSpotArray addObjectsFromArray:[WJYDataManager sharedManager].scenerySpotDataArray];
        [self.homeTableview reloadData];
        
        };
    };
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // 轮播图
    _city = @"北京";
    self.carouselImageArray = @[[UIImage imageNamed:@"beijing.jpg"],
                                [UIImage imageNamed:@"guangzhou.jpg"],
                                [UIImage imageNamed:@"shanghai.jpg"],
                                [UIImage imageNamed:@"shenzhen.jpg"],
                                [UIImage imageNamed:@"xiamen.png"]];
    
    self.carouselTextArray = @[@"北京",@"广州",@"上海",@"深圳",@"厦门"];
    self.hotCityIDArray = @[@1001,@2959,@1801,@2984,@2];
    _cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:_cycleScrollView.bounds imagesGroup:_carouselImageArray];
    _cycleScrollView.titlesGroup = _carouselTextArray;
    // 采用网络图片实现
    _cycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
    _cycleScrollView.delegate = self;
    _cycleScrollView.placeholderImage = [UIImage imageNamed:@"placeholder"];
    [self.view addSubview:_cycleScrollView];
    // 注册cell
    [self.homeTableview registerNib:[UINib nibWithNibName:@"HomeCell" bundle:nil] forCellReuseIdentifier:@"homeCell"];
    
   
    [[WJYDataManager sharedManager] getCityList];

    self.navigationController.navigationBar.translucent = NO;

    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [[WJYDataManager sharedManager] getScenicSpotContentArrayWithTypeID:[_scenicSpotArray[indexPath.row] typeID]];
    
    self.hidesBottomBarWhenPushed = YES;
    WJYScenerySpotViewController *scenerySpotVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"ScenetySpot"];
    scenerySpotVC.typeID = [_scenicSpotArray[indexPath.row] typeID];
    scenerySpotVC.headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, -kImageHight, self.view.frame.size.width, kImageHight)];
    [self.navigationController pushViewController:scenerySpotVC animated:YES];
    self.hidesBottomBarWhenPushed = NO;

}


// 分组数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
// cell数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _scenicSpotArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 200;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HomeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"homeCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    ScenerySpot *scenerySpot = _scenicSpotArray[indexPath.row];
    
    [cell.homeImage sd_setImageWithURL:[NSURL URLWithString:scenerySpot.image] placeholderImage:nil];
    cell.homeLabel.text = scenerySpot.name;
    return cell;
}
// 轮播图点击事件
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    self.hidesBottomBarWhenPushed = YES;
    WJYHotCityViewController *hotCityVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"HotCity"];
    hotCityVC.cityID = [_hotCityIDArray[index] integerValue];
    [self showViewController:hotCityVC sender:nil];
    self.hidesBottomBarWhenPushed = NO;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)cityBarButtonAcyion:(UIBarButtonItem *)sender {
    self.hidesBottomBarWhenPushed = YES;

    WJYCityViewController *cityVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"City"];
    [self showViewController:cityVC sender:nil];
    self.hidesBottomBarWhenPushed = NO;
    cityVC.reloadBlock = ^(NSInteger cityid,NSString *cityName){
        [self.navigationItem.leftBarButtonItem setTitle:cityName];
        [self.scenicSpotArray removeAllObjects];
        [self.homeTableview reloadData];
        [[WJYDataManager sharedManager] getScenicSpotDataArrayWithCityID:cityid];
    };


}


@end
