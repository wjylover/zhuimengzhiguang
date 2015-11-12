//
//  WJYDataManager.m
//  zhuimengzhiguang
//
//  Created by 王建业 on 15/11/9.
//  Copyright © 2015年 王建业. All rights reserved.
//

#import "WJYDataManager.h"
#import "HotContent.h"
#import "Hot.h"
#import "City.h"
#import "HotCity.h"
// 轮播图链接
#define kCarouselImageURL @"http://open.qyer.com/qyer/footprint/country_detail?client_id=qyer_android&client_secret=9fcaae8aefc4f9ac4915&v=1&track_deviceid=865881026677945&track_app_version=6.8.2&country_id=11"

#define kHomeHotDataURL @"http://app.xialv.com/index2.php?a=sList2&page=%ld&city_id=%ld&type=2"

#define kCityListURL @"http://app.xialv.com/index2.php?a=city&all=1"

#define kHotContentURL @"http://app.xialv.com/index2.php?a=bangdandetail&id=%ld"
//#define kHomeURL @"http://open.qyer.com/qyer/recommands/entry?client_id=qyer_android&client_secret=9fcaae8aefc4f9ac4915&v=1"
//发现下一站  http://open.qyer.com/qyer/special/topic/special_list?client_id=qyer_android&client_secret=9fcaae8aefc4f9ac4915&v=1&page=1&count=10
@implementation WJYDataManager

+ (instancetype)sharedManager
{
    static WJYDataManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [WJYDataManager new];
    });
    return manager;
}
// 获取轮播图数据
- (void)getCarouselImageData
{
    self.carouselImageArray = [NSMutableArray arrayWithCapacity:20];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:kCarouselImageURL]];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        if (!data) {
            NSLog(@"无网络访问");
            return ;
        }
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        NSDictionary *carouselDic = dict[@"data"];
        NSArray *dataArray = carouselDic[@"hot_city"];
        for (NSDictionary *dic in dataArray) {
            HotCity *hotCity = [HotCity new];
            [hotCity setValuesForKeysWithDictionary:dic];
            [self.carouselImageArray addObject:hotCity];
        }
        self.carouselBlock();
    }];
}

// 获取当地热门数据
- (void)getHomeHotDataArrayWithCityID:(NSInteger)cityID Page:(NSInteger)page;
{
    self.homeHotDataArray = [NSMutableArray arrayWithCapacity:20];
    NSString *url = [NSString stringWithFormat:kHomeHotDataURL,page,cityID];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        if (!data) {
            NSLog(@"无网络访问");
            return ;
        }
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        NSArray *dataArray = dict[@"result"];
        for (NSDictionary *dic in dataArray) {
            Hot *hot = [Hot new];
            [hot setValuesForKeysWithDictionary:dic];
            [self.homeHotDataArray addObject:hot];
        }
        self.homeHotBlock();
    }];
}

// 获取城市列表
- (void)getCityList
{
    self.cityListArray = [NSMutableArray arrayWithCapacity:20];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:kCityListURL]];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        if (!data) {
            NSLog(@"无网络访问");
            return ;
        }
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        NSArray *dataArray = dict[@"result"];
        for (NSDictionary *dict1 in dataArray) {
            NSArray *cityArray = dict1[@"cells"];
            for (NSDictionary *dict2 in cityArray) {
                City *city = [City new];
                [city setValuesForKeysWithDictionary:dict2];
                [self.cityListArray addObject:city];
            }
        }
        self.cityBlock();
    }];

}
// 获取热门内容
- (void)getHotContentDataArrayWithHotID:(NSInteger)hotID
{
    self.hotContentDataArray = [NSMutableArray arrayWithCapacity:20];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:kHotContentURL,hotID]]];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        if (!data) {
            NSLog(@"无网络访问");
            return ;
        }
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        NSArray *cellsDataArray = dict[@"result"];
        // 获取头内容
        for (NSDictionary *dic in cellsDataArray) {
            HotContent *hotContent = [HotContent new];
            [hotContent setValuesForKeysWithDictionary:dic];
            [_hotContentDataArray addObject:hotContent];
        }
        self.hotContentBlock();
    }];

}
@end
