//
//  RecommandDataManager.h
//  zhuimengzhiguang
//
//  Created by lanou3g on 15/11/9.
//  Copyright © 2015年 王建业. All rights reserved.
//

#import <Foundation/Foundation.h>

//刷新表视图block函数起别名
typedef void(^flashBlock)();


@interface RecommandDataManager : NSObject

//存储所有用户的数组
@property(nonatomic,strong) NSArray *users;
//存储所有英里数对象的数组
@property(nonatomic,strong) NSArray *miles;




//block变量
@property(nonatomic,strong) flashBlock flash;



//声明类方法，创建单例对象
+(instancetype)sharedRecommandDataManager;

//根据传过来的url解析数据
-(void)analysisDataFromUrl:(NSString *)urlString;


@end
