//
//  WJYHomeViewController.m
//  zhuimengzhiguang
//
//  Created by 王建业 on 15/11/9.
//  Copyright © 2015年 王建业. All rights reserved.
//

#import "WJYHomeViewController.h"
#import "NSString+Characters.h"
#import "WJYWeatherView.h"
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

#define kWeatherImageURL @"http://php.weather.sina.com.cn/images/yb3/180_180/%@_0.png"
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


//存储当前城市的这一周的天气对象
@property(nonatomic,strong)NSMutableArray *weatherArray;

@end

@implementation WJYHomeViewController


- (void)viewWillAppear:(BOOL)animated
{
  
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0.313 green:0.782 blue:1.000 alpha:1.000];

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
    _cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, -200, self.view.frame.size.width, 200) imagesGroup:_carouselImageArray];
    _cycleScrollView.titlesGroup = _carouselTextArray;
    // 采用网络图片实现
    _cycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
    _cycleScrollView.delegate = self;
    _cycleScrollView.placeholderImage = [UIImage imageNamed:@"placeholder"];
    self.homeTableview.contentInset = UIEdgeInsetsMake(200 , 0, 0, 0);
    [self.homeTableview addSubview:_cycleScrollView];
    // 注册cell
    [self.homeTableview registerNib:[UINib nibWithNibName:@"HomeCell" bundle:nil] forCellReuseIdentifier:@"homeCell"];
    
   
    [[WJYDataManager sharedManager] getCityList];

    self.navigationController.navigationBar.translucent = NO;
    
    //根据城市名获得天气状况
    [self analysisWeatherByCityName:_city];
    
    //自动设置cell的高度
    self.homeTableview.rowHeight = UITableViewAutomaticDimension;
    self.homeTableview.estimatedRowHeight = 50;

    
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
    cityVC.reloadBlock = ^(NSInteger cityid,NSString *cityName){
        self.city = cityName;
        [self.navigationItem.leftBarButtonItem setTitle:cityName];
        [self.scenicSpotArray removeAllObjects];
        [self.homeTableview reloadData];
        [[WJYDataManager sharedManager] getScenicSpotDataArrayWithCityID:cityid];
        
        //调用天气解析数据
        [self analysisWeatherByCityName:cityName];
    };
    self.hidesBottomBarWhenPushed = NO;


}


//设置tableView的区头的高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 150;
}

//设置tableView的区尾的高度
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{

    return 1;
}

//在tableView的区头视图
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (_weatherArray.count == 0) {
        return nil;
    }
    NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"WJYWeatherView" owner:self options:nil];
    Weather *weather = _weatherArray[0];
    WJYWeatherView *weatherView = [nib objectAtIndex:0];
    weatherView.cityLabel.text = self.city;
    weatherView.typeLabel.text = weather.type;
    weatherView.windLabel.text = [weather.fengli substringToIndex:[weather.fengli length] - 1];
    weatherView.weekLabel.text = [weather.date substringFromIndex:[weather.date length] - 3];
    NSString *temp = [NSString stringWithFormat:@"%@~%@",[weather.low substringFromIndex:2],[weather.high substringFromIndex:2]];
    weatherView.tempLabel.text = temp;
    NSString *type = [weather.type pinyinOfString];
    NSString *strUrl = [type stringByReplacingOccurrencesOfString:@" " withString:@""];
    [weatherView.typeImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:kWeatherImageURL,strUrl]]];
    
    NSDate *currentDate = [NSDate date];//获取当前时间，日期
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MM/dd"];
    NSString *dateString = [dateFormatter stringFromDate:currentDate];
    weatherView.dayLabel.text = dateString;
    
    UIImageView *backImage= [[UIImageView alloc] initWithFrame:CGRectMake(0, 3, weatherView.frame.size.width, 146)];
    backImage.image = [UIImage imageNamed:@"5.jpg"];
    [weatherView addSubview:backImage];
    [weatherView insertSubview:backImage atIndex:0];
    weatherView.backgroundColor = [UIColor whiteColor];
    return weatherView;
}


//根据获得的城市名解析天气的数据
-(void)analysisWeatherByCityName:(NSString *)cityName{
     //清空天气数组
    [self.weatherArray removeAllObjects];
    
     // 将中文转为UTF8编码
    NSString *typeString = (__bridge NSString *)CFURLCreateStringByAddingPercentEscapes(NULL,(__bridge CFStringRef)cityName,NULL,(CFStringRef)@"!*'();:@&=+$,/?%#[]",kCFStringEncodingUTF8);
    
    NSString *urlString = [kWeatherURL stringByAppendingString:typeString];
    NSURL *url = [NSURL URLWithString:urlString];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue]completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        if (data == nil) {
            return ;
        }
    
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        NSDictionary *dataDic = dict[@"data"];
        
        NSArray *forecast = dataDic[@"forecast"];
        
        for (NSDictionary *dic in forecast) {
            //循环数组,创建天气对象
            Weather *weather = [Weather new];
            [weather setValuesForKeysWithDictionary:dic];
            
            [self.weatherArray addObject:weather];
            
        }
        
    
        //刷新表视图
        [self.homeTableview reloadData];
    }];
    
}


-(NSMutableArray *)weatherArray{
    if (!_weatherArray) {
        _weatherArray = [NSMutableArray array];
    }
    return _weatherArray;
}

@end
