//
//  GoodLocalRequestHandle.m
//  zhuimengzhiguang
//
//  Created by lanou3g on 15/11/18.
//  Copyright © 2015年 王建业. All rights reserved.
//

#import "GoodLocalRequestHandle.h"
#import "GoodLocalCityModel.h"

@interface GoodLocalRequestHandle ()

@property (nonatomic,strong) NSMutableArray *allDataArray;

@end

@implementation GoodLocalRequestHandle

+(instancetype)shareGoodLocalRequestHandle
{
    static GoodLocalRequestHandle *request = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        request = [[GoodLocalRequestHandle alloc]init];
    });
    
    return request;
}

-(void)requestGoodLocalRequestHandle
{
    //防止不同信息的重复载入
//    if (page == 1) {
        [self.allDataArray removeAllObjects];
//    }
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        
        NSString *url = [NSString stringWithFormat:@"http://open.qyer.com/qyer/discount/local_discount?client_id=qyer_android&client_secret=9fcaae8aefc4f9ac4915&v=1&track_deviceid=865881026677945&track_app_version=6.8.2&track_app_channel=oppo&track_device_info=R831S&track_os=Android4.3&app_installtime=1446885441172&lat=40.030443&lon=116.343671&type=2&id=%ld&count=10&page=1&product_type=2410&time=1&order=2",self.ID];

        NSURLSession *urlSession = [NSURLSession sharedSession];
        
        NSURLSessionDataTask *dataTask = [urlSession dataTaskWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
           
            NSDictionary *dataDic = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingAllowFragments) error:nil];
            
            NSDictionary *dic = [NSDictionary dictionary];
            dic = [dataDic valueForKey:@"data"];
            
            NSArray *array = [NSArray array];
            array = [dic valueForKey:@"list"];
            
            for (NSDictionary *dict in array) {
                
                GoodLocalCityModel *model = [[GoodLocalCityModel alloc]init];
                [model setValuesForKeysWithDictionary:dict];
                [self.allDataArray addObject:model];
                
            }
            
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
