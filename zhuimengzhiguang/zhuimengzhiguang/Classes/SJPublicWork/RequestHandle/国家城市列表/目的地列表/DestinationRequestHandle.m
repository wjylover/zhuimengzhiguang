//
//  DestinationRequestHandle.m
//  zhuimengzhiguang
//
//  Created by lanou3g on 15/11/13.
//  Copyright © 2015年 王建业. All rights reserved.
//

#import "DestinationRequestHandle.h"
#import "DestinationContinentsModel.h"
#import "URL.h"

@interface DestinationRequestHandle ()

@property (nonatomic,strong) NSMutableArray *allDataArray;

@end

@implementation DestinationRequestHandle

//单例
+(instancetype)shareDDestinationRequestHandle
{
    static DestinationRequestHandle *request = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        request = [[DestinationRequestHandle alloc]init];
    });
    return request;
}

//请求数据
-(void)destinationRequestHandle
{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
       
        [self.allDataArray removeAllObjects];
        
        NSURLSession *urlSession = [NSURLSession sharedSession];
        
        NSURLSessionDataTask *dataTask = [urlSession dataTaskWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:UrlDestination]] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingAllowFragments) error:nil];
            
            NSMutableArray *array = [NSMutableArray array];
            array = [dic valueForKey:@"data"];
            
            for (NSDictionary *dict in array) {
                
                //接收五大洲的模型数据
                DestinationContinentsModel *continentsModel = [DestinationContinentsModel new];
                [continentsModel setValuesForKeysWithDictionary:dict];
                [self.allDataArray addObject:continentsModel];
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                self.result();
            });
           
        }];
        
        [dataTask resume];
        
    });
}

#pragma mark -- 懒加载 --
-(NSArray *)destinationArray
{
    return self.allDataArray;
}
-(NSMutableArray *)allDataArray
{
    if (!_allDataArray) {
        self.allDataArray = [[NSMutableArray alloc]init];
    }
    return _allDataArray;
}

@end
