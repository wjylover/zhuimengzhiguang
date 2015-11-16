//
//  DesCityPriceHandle.m
//  zhuimengzhiguang
//
//  Created by lanou3g on 15/11/14.
//  Copyright © 2015年 王建业. All rights reserved.
//

#import "DesCityPriceHandle.h"
#import "DesCityPriceModel.h"

@interface DesCityPriceHandle ()

@property (nonatomic,strong) NSMutableArray *allDataArray;

@end

@implementation DesCityPriceHandle

static int page = 1;

+(instancetype)shareDesCityPriceHandle
{
    static DesCityPriceHandle *request = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        request = [[DesCityPriceHandle alloc]init];
    });
    return request;
}

-(void)requestDesCityPriceHandle
{
//    [self.allDataArray removeAllObjects];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
       
        //数据的拼接
        NSString *url = [NSString stringWithFormat:@"http://open.qyer.com/qyer/discount/tickets_freewalker?client_id=qyer_android&client_secret=9fcaae8aefc4f9ac4915&v=1&track_deviceid=865881026677945&track_app_version=6.8.2&app_installtime=1446885441172&lat=40.029921&lon=116.343528&type=1&id=%@&count=10&page=%d&product_type=1016,1018,1020&time=1&order=2",self.ID,page];
        //网络请求
        NSURLSession *urlSession = [NSURLSession sharedSession];
        
        NSURLSessionDataTask *dataTask = [urlSession dataTaskWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
           
            NSDictionary *dataDic = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingAllowFragments) error:nil];
            
            NSDictionary *dict = [NSDictionary dictionary];
            dict = [dataDic valueForKey:@"data"];
            
            NSArray *array = [NSArray array];
            array = [dict valueForKey:@"list"];
            
            for (NSDictionary *dict in array) {
                DesCityPriceModel *model = [DesCityPriceModel new];
                [model setValuesForKeysWithDictionary:dict];
                [self.allDataArray addObject:model];
            }
            //主线程
            dispatch_async(dispatch_get_main_queue(), ^{
                self.result();
                page++;
            });
            
        }];
        
        [dataTask resume];
        
    });
}

#pragma mark --- 懒加载 ---
-(NSMutableArray *)allDataArray
{
    if (!_allDataArray) {
        self.allDataArray = [NSMutableArray array];
    }
    return _allDataArray;
}
-(NSMutableArray *)dataArray
{
    return self.allDataArray;
}


@end
