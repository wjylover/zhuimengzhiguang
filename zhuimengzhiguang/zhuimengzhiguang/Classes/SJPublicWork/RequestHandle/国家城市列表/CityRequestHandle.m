//
//  CityRequestHandle.m
//  zhuimengzhiguang
//
//  Created by lanou3g on 15/11/11.
//  Copyright © 2015年 王建业. All rights reserved.
//

#import "CityRequestHandle.h"
#import "CountryDesModel.h"
#import "URL.h"

@interface CityRequestHandle ()
@property (nonatomic,retain) NSMutableArray *allDataArray;

@end

@implementation CityRequestHandle

+(instancetype)shareCityReqeustHandle
{
    static CityRequestHandle *requestHandle = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        requestHandle = [[CityRequestHandle alloc]init];
    });
    return requestHandle;
}

//数据请求
-(void)CityWithRequestHandle
{
    [self.allDataArray removeAllObjects];
    
    NSString *url = [NSString stringWithFormat:@"http://open.qyer.com/qyer/footprint/country_detail?client_id=qyer_android&client_secret=9fcaae8aefc4f9ac4915&v=1&track_deviceid=865881026677945&track_app_version=6.8.2&track_app_channel=oppo&track_device_info=R831S&track_os=Android4.3&app_installtime=1446885441172&lat=40.030737&lon=116.336378&country_id=%ld",self.ID];
    
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{

        NSURLSession *urlSession = [NSURLSession sharedSession];
        NSURLSessionDataTask *dataTask = [urlSession dataTaskWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
           
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingAllowFragments) error:nil];
            //创建信息字典
            NSDictionary *dictionary = [NSDictionary dictionary];
            /*
             * 由字典的key值 得到value , 此时 value 仍是字典
             */
            dictionary = dic[@"data"];
            
//            //创建对象数组
//            self.allDataArray = [NSMutableArray arrayWithCapacity:20];
            
            //创建 数据模型
            CountryDesModel *model = [CountryDesModel new];
            //根本不能取值 取值就会报错
            [model setValuesForKeysWithDictionary:dictionary];
            //将model 添加到数组对象中
            [self.allDataArray addObject:model];

            dispatch_async(dispatch_get_main_queue(), ^{
                self.result();
            });
        }];
        [dataTask resume];
        
    });
}


#pragma mark -- 懒加载 --
-(NSMutableArray *)allDataArray
{
    if (!_allDataArray) {
        self.allDataArray = [NSMutableArray array];
    }
    return _allDataArray;
}

-(NSArray *)dataArray
{
    return self.allDataArray;
}


@end
