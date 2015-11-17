//
//  Weather.h
//  zhuimengzhiguang
//
//  Created by lanou3g on 15/11/16.
//  Copyright © 2015年 王建业. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Weather : NSObject

//日期
@property(nonatomic,copy)NSString *date;
//风力
@property(nonatomic,copy)NSString *fengli;
//风向
@property(nonatomic,copy)NSString *fengxiang;
//最高温度
@property(nonatomic,strong)NSString *high;
//最低温度
@property(nonatomic,strong)NSString *low;
//天气类型
@property(nonatomic,strong)NSString *type;






@end
