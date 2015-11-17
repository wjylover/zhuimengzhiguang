//
//  ShowInformationDataManager.m
//  zhuimengzhiguang
//
//  Created by lanou3g on 15/11/10.
//  Copyright © 2015年 王建业. All rights reserved.
//

#import "ShowInformationDataManager.h"

@interface ShowInformationDataManager ()

//创建一个可变数组存储日志对象
@property(nonatomic,strong)NSMutableArray *logArray;

@end

@implementation ShowInformationDataManager

//创建单例对象
+(instancetype)sharedShowInformationDataManager{
    static ShowInformationDataManager *showInfoDM = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        showInfoDM = [[ShowInformationDataManager alloc] init];
    });
    return showInfoDM;
}

-(instancetype)init{

    if (self = [super init]) {
        _logArray = [NSMutableArray array];
        _allLogs = [NSArray array];
    }
    return self;
}



//根据传入的mileage对象,解析数据
-(void)analysiseDataByMileage:(Mileage *)mileage{
    
    //清除数组内容
    [_logArray removeAllObjects];
    
    //跳入子线程解析数据
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
       
        NSString *urlString = [NSString stringWithFormat:@"%@%ld",kRecommandInformationURL,mileage.journeyId];
        
        NSURL *url = [NSURL URLWithString:urlString];
        
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        
        [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
         
            
            if (data == nil) {
                return ;
            }
            
            //解析数据
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
            
            //创建用户对象
            User *user = [User new];
            //根据键获得值
           NSDictionary *userDic = dict[@"user"];
            //给用户对象赋属性
            [user setValuesForKeysWithDictionary:userDic];
            
            //创建英里对象
            Mileage *mileage = [Mileage new];
            //根据键获得值
            NSDictionary *mileDic = dict[@"mileage"];
            //给英里对象赋属性
            [mileage setValuesForKeysWithDictionary:mileDic];
            
            //根据键获得日志数组
            NSArray *logList = dict[@"loglist"];
            //循环数组,封装日志对象
            for (NSDictionary *dic in logList) {
                //创建日志对象
                Loglist *log = [Loglist new];
                //给对象赋值
                [log setValuesForKeysWithDictionary:dic];
                
                //将日志对象加入数组中
                [_logArray addObject:log];
            }
            
            
            //回到主线程
            dispatch_async(dispatch_get_main_queue(), ^{
                
                //调用block变量,将值传出
                self.getValue(user,mileage);
                
                //调用block变量,刷新集合视图
                self.flash();
                
            });
        }];
        
        
    });
    
    
}



-(NSArray *)allLogs{
    return _logArray;
}

@end
