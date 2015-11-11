//
//  DestinationContinentsModel.m
//  zhuimengzhiguang
//
//  Created by lanou3g on 15/11/9.
//  Copyright © 2015年 王建业. All rights reserved.
//

#import "DestinationContinentsModel.h"
#import "DestinationCountryModel.h"

@implementation DestinationContinentsModel

-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"id"]) {
        self.ID = value;
    }
    
    //字典获取对应的key, 如果是字典中的数组 "country", 就将其数据遍历
    if ([key isEqualToString:@"country"]) {
        //创建对象数组
        self.country = [NSMutableArray array];
        //遍历 "country" 数据数组
        for (NSDictionary *dic in value) {
            //创建模型数据
            DestinationCountryModel *model = [DestinationCountryModel new];
            //kvc取值
            [model setValuesForKeysWithDictionary:dic];
            //添加到对象数组中
            [self.country addObject:dic];
        }
    }
    if ([key isEqualToString:@"hot_country"]) {
        self.hot_country = [NSMutableArray array];
        for (NSDictionary *dic in value) {
            DestinationCountryModel *model = [DestinationCountryModel new];
            [model setValuesForKeysWithDictionary:dic];
            [self.hot_country addObject:model];
        }
    }
}

//重写description方法
-(NSString *)description
{
    return [NSString stringWithFormat:@"cname:%@, ename:%@",_cnname,_enname];
}

@end
