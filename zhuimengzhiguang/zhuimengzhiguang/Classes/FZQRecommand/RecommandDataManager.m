//
//  RecommandDataManager.m
//  zhuimengzhiguang
//
//  Created by lanou3g on 15/11/9.
//  Copyright © 2015年 王建业. All rights reserved.
//

#import "RecommandDataManager.h"

@interface RecommandDataManager ()


//声明一个可变数组，存放用户
@property(nonatomic,strong) NSMutableArray *allUsers;
//声明一个可变数组，存放英里数
@property(nonatomic,strong) NSMutableArray *allMiles;
//声明一个page数
@property(nonatomic,assign) int page;


@end


@implementation RecommandDataManager

//声明类方法，创建单例对象
+(instancetype)sharedRecommandDataManager{
    static RecommandDataManager *recommandDM = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        recommandDM = [[RecommandDataManager alloc] init];
    });
    return recommandDM;
}

//重写初始化方法,初始化数组和page数
-(instancetype)init{
    if(self = [super init]){
        //创建数组
        _allMiles = [NSMutableArray array];
        _allUsers = [NSMutableArray array];
        _page = 0;
    }
    
    return self;
}


//根据传过来的url解析数据
-(void)analysisDataFromUrl:(NSString *)urlString{
    
    //进入子线程请求数据
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
      
        //拼接url
        NSString *stringUrl = [NSString stringWithFormat:@"%@%d",urlString,_page];
        
        //创建url对象
        NSURL *url = [NSURL URLWithString:stringUrl];
        
        //创建请求对象
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        
        //请求数据
        [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue]  completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
            
            //解析数据
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
            //根据键值获得数组
            NSArray *array = dict[@"list"];
            //从第一个元素开始循环数组
            for (int i = 1; i<array.count; i++) {
               //获得数组中的小字典
                NSDictionary *dic = array[i];
                //创建用户对象
                User *user = [User new];
                //根据小字典获得字典的第一个元素
                NSDictionary *userDic = dic[@"user"];
                //设置用户的属性
                [user setValuesForKeysWithDictionary:userDic];
                //将创建成功的用户加入用户数组中
                [_allUsers addObject:user];
                
                //创建英里对象
                Mileage *mileage = [Mileage new];
                //根据小字典获得字典的第二个元素
                NSDictionary *mileDic = dic[@"mileage"];
                //设置英里对象的属性
                [mileage setValuesForKeysWithDictionary:mileDic];
                //将创建成功的用户加入用户数组中
                [_allMiles addObject:mileage];
                
            }
            
            //校验
//            for (User *user in _allUsers) {
//                NSLog(@"%@",user);
//            }
//            
//            for (Mileage *mileage in _allMiles) {
//                NSLog(@"%@",mileage);
//            }
            
            //page加一
            _page ++;
            
            //回到主线程刷新表视图
            dispatch_async(dispatch_get_main_queue(), ^{
                
                self.flash();
                
            });
            
        }];
        
        
    });
    
}


//重写数组的getter方法
-(NSArray *)users{
    return _allUsers;
}


-(NSArray *)miles{
    return _allMiles;
}


@end
