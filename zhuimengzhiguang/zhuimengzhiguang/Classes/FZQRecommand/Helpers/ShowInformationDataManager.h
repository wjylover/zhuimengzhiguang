//
//  ShowInformationDataManager.h
//  zhuimengzhiguang
//
//  Created by lanou3g on 15/11/10.
//  Copyright © 2015年 王建业. All rights reserved.
//

#import <Foundation/Foundation.h>

//给block变量起别名,将用户对象和mileage对象的值传出
typedef void(^getValueBlock)(User *user,Mileage *mileage);


@interface ShowInformationDataManager : NSObject

//声明block变量传值
@property(nonatomic,strong)getValueBlock getValue;

//创建一个数组存储日志对象
@property(nonatomic,strong)NSArray *allLogs;



//创建单例对象
+(instancetype)sharedShowInformationDataManager;


//根据传入的mileage对象,解析数据
-(void)analysiseDataByMileage:(Mileage *)mileage;

@end
