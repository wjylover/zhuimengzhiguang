//
//  WJYDataManager.m
//  zhuimengzhiguang
//
//  Created by 王建业 on 15/11/9.
//  Copyright © 2015年 王建业. All rights reserved.
//

#import "WJYDataManager.h"
#import "HotCity.h"
// 轮播图链接
#define kCarouselImageURL @"http://open.qyer.com/qyer/footprint/country_detail?client_id=qyer_android&client_secret=9fcaae8aefc4f9ac4915&v=1&track_deviceid=865881026677945&track_app_version=6.8.2&country_id=11"
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

@end
