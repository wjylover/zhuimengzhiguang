//
//  MoreDesCityRequestHandle.m
//  zhuimengzhiguang
//
//  Created by lanou3g on 15/11/17.
//  Copyright © 2015年 王建业. All rights reserved.
//

#import "MoreDesCityRequestHandle.h"
#import "MoreDesCityModel.h"

@interface MoreDesCityRequestHandle ()

@property (nonatomic,strong) NSMutableArray *allDataArray;

@end

@implementation MoreDesCityRequestHandle

//static int page = 1;

+(instancetype)shareMoreDesCityRequestHandle
{
    static MoreDesCityRequestHandle *request = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        request = [[MoreDesCityRequestHandle alloc]init];
    });
    
    return request;
}

-(void)requestHandleWithMoreDesCityRequestHandle
{
//    if (page == 1) {
    
        [self.allDataArray removeAllObjects];
//    }
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
       
        NSString *url = [NSString stringWithFormat:@"http://open.qyer.com/qyer/discount/tickets_freewalker?client_id=qyer_android&client_secret=9fcaae8aefc4f9ac4915&v=1&track_deviceid=865881026677945&track_app_version=6.8.2&track_app_channel=oppo&track_device_info=R831S&track_os=Android4.3&app_installtime=1446885441172&lat=40.030443&lon=116.343671&type=2&id=%ld&count=10&page=1&product_type=1016,1018,1020&time=1&order=2",self.ID];

        NSURLSession *urlSession = [NSURLSession sharedSession];
        
        NSURLSessionDataTask *dataTask = [urlSession dataTaskWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            
            NSDictionary *dataDic = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingAllowFragments) error:nil];
            
            NSDictionary *dic = [NSDictionary dictionary];
            dic = [dataDic valueForKey:@"data"];
            
            NSArray *array = [NSArray array];
            array = [dic valueForKey:@"list"];
            
            for (NSDictionary *dict in array) {
                MoreDesCityModel *model = [[MoreDesCityModel alloc]init];
                [model setValuesForKeysWithDictionary:dict];
                [self.allDataArray addObject:model];
            }
            //回归主线程
            dispatch_async(dispatch_get_main_queue(), ^{
                //回调
                self.result();
                
            });
            
        }];
        [dataTask resume];
        
    });
}


//懒加载
-(NSMutableArray *)allDataArray
{
    if (!_allDataArray) {
        self.allDataArray = [NSMutableArray array];
    }
    //用self 会形成回调<递归>
    return _allDataArray;
}

-(NSArray *)dataArray
{
    return self.allDataArray;
}


@end
