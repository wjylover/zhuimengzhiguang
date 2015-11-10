//
//  RequestHandle.m
//  zhuimengzhiguang
//
//  Created by lanou3g on 15/11/9.
//  Copyright © 2015年 王建业. All rights reserved.
//

#import "RequestHandle.h"
#import "DestinationContinentsModel.h"
#import "DestinationCountryModel.h"
#import "URL.h"
@interface RequestHandle ()

//目的地列表对象数组
@property (nonatomic,strong) NSMutableArray *destinationArray;
//国家对象数组
@property (nonatomic,strong) NSMutableArray *countryArray;

@end

@implementation RequestHandle

+(instancetype)sharedRequestHandle
{
    static RequestHandle *requestHandle = nil;
    
    @synchronized(self) {
        requestHandle = [[RequestHandle alloc]init];
    }
    
    return requestHandle;
}

//目的地列表的网络请求
-(void)destinationWithUrlString
{
    [self.destinationArray removeAllObjects];
    [self.countryArray removeAllObjects];
    
    
        NSURLSession *urlSession = [NSURLSession sharedSession];
        
        NSURLSessionDataTask *dataTask = [urlSession dataTaskWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:UrlDestination]] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingAllowFragments) error:nil];
            
            NSMutableArray *array = [NSMutableArray array];
            array = [dic valueForKey:@"data"];
            
            for (NSDictionary *dict in array) {
                
                //接收五大洲的模型数据
                DestinationContinentsModel *continentsModel = [DestinationContinentsModel new];
                [continentsModel setValuesForKeysWithDictionary:dict];
                [self.destinationArray addObject:continentsModel];
                
                //遍历目的地
                for (NSDictionary *dictionary in dict[@"country"]) {
                    
                    DestinationCountryModel *model = [DestinationCountryModel new];
                    [model setValuesForKeysWithDictionary:dictionary];
                    [self.countryArray addObject:model];
                    
                }
                //遍历热门目的地
                for (NSDictionary *dictionary in dict[@"hot_country"]) {
                    DestinationCountryModel *model = [DestinationCountryModel new];
                    [model setValuesForKeysWithDictionary:dictionary];
                    [self.countryArray addObject:model];
                }
                
                
            }
            NSLog(@"==%@==",self.destinationArray);
        }];
        
        [dataTask resume];

    
    /*
    //第三方 AFNetworking
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:UrlDestination parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        
        NSMutableArray *array = [NSMutableArray array];
        array = [responseObject valueForKey:@"data"];
        
        
        for (NSDictionary *dict in array) {
            
            //接收七大洲的模型数据
            DestinationContinentsModel *continentsModel = [DestinationContinentsModel new];
            [continentsModel setValuesForKeysWithDictionary:dict];
            [self.destinationArray addObject:continentsModel];
            
            //遍历目的地
            for (NSDictionary *dictionary in dict[@"country"]) {
                
                DestinationCountryModel *model = [DestinationCountryModel new];
                [model setValuesForKeysWithDictionary:dictionary];
                [self.countryArray addObject:model];
                
            }
            //遍历热门目的地
            for (NSDictionary *dictionary in dict[@"hot_country"]) {
                DestinationCountryModel *model = [DestinationCountryModel new];
                [model setValuesForKeysWithDictionary:dictionary];
                [self.countryArray addObject:model];
            }
            self.destinaArray = [NSArray array];
            self.destinaArray = self.destinationArray;
            
            NSLog(@"destina: %ld",_destinaArray.count);
        }
        
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        
        NSLog(@"%@",error);
    }];

     */
    
}


#pragma mark -- 懒加载 --
-(NSMutableArray *)destinationArray
{
    if (!_destinationArray) {
        self.destinationArray = [NSMutableArray array];
    }
    return _destinationArray;
}

-(NSMutableArray *)countryArray
{
    if (!_countryArray) {
        self.countryArray = [NSMutableArray array];
    }
    return _countryArray;
}


-(NSArray *)destinaArray
{
    return self.destinationArray;
}
-(NSArray *)countriesArray
{
    return self.countryArray;
}


@end
