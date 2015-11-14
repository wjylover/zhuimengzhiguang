//
//  WJYHomeViewController.m
//  zhuimengzhiguang
//
//  Created by 王建业 on 15/11/9.
//  Copyright © 2015年 王建业. All rights reserved.
//

#import "WJYHomeViewController.h"
#import "HotContentViewController.h"
#import "WJYScenerySpotViewController.h"
#import "ScenerySpotContent.h"
#import "ScenerySpot.h"
#import "WJYCityViewController.h"
#import "Hot.h"
#import "City.h"
#import <CoreLocation/CoreLocation.h>
#import "HomeCell.h"
#import "WJYDataManager.h"
#import "HotCity.h"
#import <UIImageView+WebCache.h>
#import <SDCycleScrollView.h>
#import <MJRefresh.h>
#define kImageHight [UIScreen mainScreen].bounds.size.width / (490 / 285.0)

@interface WJYHomeViewController ()<SDCycleScrollViewDelegate,UITableViewDataSource,UITableViewDelegate,CLLocationManagerDelegate>
// 轮播图控件
@property (weak, nonatomic) IBOutlet SDCycleScrollView *cycleScrollView;
// 轮播图数据数组
@property (nonatomic, strong) NSMutableArray *carouselImageArray;
@property (nonatomic, strong) NSMutableArray *carouselTextArray;
@property (nonatomic, strong) NSMutableArray *cityListArray;
// 热门城市数据
@property (nonatomic, strong) NSMutableArray *homeHotArray;
// 普通城市景点数据
@property (nonatomic, strong) NSMutableArray *scenicSpotArray;

@property (weak, nonatomic) IBOutlet UITableView *homeTableview;
// 定位服务
@property (nonatomic, strong) CLLocationManager *manager;
// 用户当前位置
@property (nonatomic, strong) CLLocation *userLocation;
// 当前位置的城市名
@property (nonatomic, strong) NSString *city;
// 当前当前位置的城市ID
@property (nonatomic, assign) NSInteger cityID;

@end

@implementation WJYHomeViewController


- (void)viewWillAppear:(BOOL)animated
{
    // 加载轮播图数据
    [[WJYDataManager sharedManager] getCarouselImageData];
    // 数据加载完回调
    [WJYDataManager sharedManager].carouselBlock = ^(){
        // 初始化数组
        self.carouselImageArray = [NSMutableArray arrayWithCapacity:4];
        self.carouselTextArray = [NSMutableArray arrayWithCapacity:4];
        for (HotCity *hotCity in [WJYDataManager sharedManager].carouselImageArray) {
            // 轮播图图片数组
            [self.carouselImageArray addObject:hotCity.photo];
            // 轮播图文子数组
            [self.carouselTextArray addObject:hotCity.cnname];
            _cycleScrollView.imageURLStringsGroup = _carouselImageArray;
            _cycleScrollView.titlesGroup = _carouselTextArray;
        }
    };
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

//        _homeHotArray = [NSMutableArray arrayWithCapacity:20];
//        [[WJYDataManager sharedManager] getHomeHotDataArrayWithCityID:_cityID Page:page];
//        [WJYDataManager sharedManager].homeHotBlock = ^(){
//            [_homeHotArray addObjectsFromArray:[WJYDataManager sharedManager].homeHotDataArray];
//            [self.homeTableview reloadData];
//                [self.homeTableview.mj_footer endRefreshing];
//            if ([WJYDataManager sharedManager].homeHotDataArray.count == 0) {
//                
//                [self.homeTableview.mj_footer endRefreshingWithNoMoreData];
//            }
//        };
    };
}

// 加载数据
- (void)loadData
{
    //[[WJYDataManager sharedManager] getHomeHotDataArrayWithCityID:_cityID Page:page];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // 采用网络图片实现
    _cycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
    _cycleScrollView.delegate = self;
    //_cycleScrollView.dotColor = [UIColor yellowColor]; // 自定义分页控件小圆标颜色
    _cycleScrollView.placeholderImage = [UIImage imageNamed:@"placeholder"];
    [self.view addSubview:_cycleScrollView];
    // 注册cell
    [self.homeTableview registerNib:[UINib nibWithNibName:@"HomeCell" bundle:nil] forCellReuseIdentifier:@"homeCell"];
    // 定位
    self.manager = [[CLLocationManager alloc] init];
    self.manager.delegate = self;
    self.manager.desiredAccuracy = kCLLocationAccuracyBest;
    
    // 判断设备版本
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        [self.manager requestWhenInUseAuthorization];
    }
    [self.manager startUpdatingLocation];
    
//    self.homeTableview.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
//        page ++;
//        [self loadData];
//    }];
    self.navigationController.navigationBar.translucent = NO;

    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [[WJYDataManager sharedManager] getScenicSpotContentArrayWithTypeID:[_scenicSpotArray[indexPath.row] typeID]];
    
    self.hidesBottomBarWhenPushed = YES;
    WJYScenerySpotViewController *scenerySpotVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"ScenetySpot"];
    //hotContentVC.hot = self.homeHotArray[indexPath.row];
    //HomeCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    //hotContentVC.headImageView.frame = CGRectMake(0, -kImageHight, self.view.frame.size.width, kImageHight);
    //hotContentVC.headImageView = [[UIImageView alloc] initWithImage:cell.homeImage.image ];

    scenerySpotVC.headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, -kImageHight, self.view.frame.size.width, kImageHight)];
    [self.navigationController pushViewController:scenerySpotVC animated:YES];
    self.hidesBottomBarWhenPushed = NO;

}
// 获取用户当前位置
- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    
    //地理逆编码
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder reverseGeocodeLocation:newLocation completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        if(!error)
        {
            CLPlacemark *mark = placemarks[0];
            NSDictionary *dict = mark.addressDictionary;
            _city = dict[@"City"];
            static dispatch_once_t onceToken;
            dispatch_once(&onceToken, ^{
                
                [[WJYDataManager sharedManager] getCityList];
            });
        }
    }];
    // 停止位置更新
    [manager stopUpdatingLocation];
}

// 定位失误时触发
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"error:%@",error);
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
// 定义tableView头区的高度
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
//{
//    return 100;
//}

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
    NSLog(@"---点击了第%ld张图片", index);
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
    cityVC.reloadBlock = ^(NSInteger cityid){
//        [self.homeHotArray removeAllObjects];
        [self.scenicSpotArray removeAllObjects];
        [self.homeTableview reloadData];
        //[[WJYDataManager sharedManager] getHomeHotDataArrayWithCityID:cityid Page:page];
        [[WJYDataManager sharedManager] getScenicSpotDataArrayWithCityID:cityid];
    };


}


@end
