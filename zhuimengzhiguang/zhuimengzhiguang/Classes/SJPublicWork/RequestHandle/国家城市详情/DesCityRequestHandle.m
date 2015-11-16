//
//  DesCityRequestHandle.m
//  zhuimengzhiguang
//
//  Created by lanou3g on 15/11/14.
//  Copyright © 2015年 王建业. All rights reserved.
//

#import "DesCityRequestHandle.h"
#import "DesCityModel.h"
#import "URL.h"

@interface DesCityRequestHandle ()

@property (nonatomic,strong) NSMutableArray *allDataArray;

@end

@implementation DesCityRequestHandle

+(instancetype)shareDesCityRequestHandle
{
    static DesCityRequestHandle *request = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        request = [[DesCityRequestHandle alloc]init];
    });
    return request;
}

-(void)requestHandleDesCityRequestHandle
{
    //清空数组
    [self.allDataArray removeAllObjects];
    //子线程
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
       
        NSString *url = [NSString stringWithFormat:@"%@%@",UrlMoreFire,self.ID];
        //打印
        NSLog(@"%@",url);
        //网络请求
        NSURLSession *urlSession = [NSURLSession sharedSession];
        
        NSURLSessionDataTask *dataTask = [urlSession dataTaskWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            
            NSDictionary *dataDic = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingAllowFragments) error:nil];
            NSArray *dataArray = [NSArray array];
            
            dataArray = [dataDic valueForKey:@"data"];
            
            for (NSDictionary *dic in dataArray) {
                DesCityModel *model = [[DesCityModel alloc]init];
                [model setValuesForKeysWithDictionary:dic];
                [self.allDataArray addObject:model];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
               
                self.result();
            });
            
            
        }];
        [dataTask resume];
        
    });
}

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
