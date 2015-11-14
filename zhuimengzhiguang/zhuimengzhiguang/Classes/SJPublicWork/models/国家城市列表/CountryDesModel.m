//
//  CountryDesModel.m
//  zhuimengzhiguang
//
//  Created by lanou3g on 15/11/11.
//  Copyright © 2015年 王建业. All rights reserved.
//

#import "CountryDesModel.h"
#import "CityModel.h"
#import "CityPriceModel.h"

@implementation CountryDesModel

-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"id"]) {
        self.ID = value;
    }
    if ([key isEqualToString:@"hot_city"]) {
        self.hot_city = [NSMutableArray array];
        for (NSDictionary *dic in value) {
            CityModel *model = [CityModel new];
            [model setValuesForKeysWithDictionary:dic];
            [self.hot_city addObject:model];
        }
    }
    if ([key isEqualToString:@"new_discount"]) {
        self.discount = [NSMutableArray array];
        for (NSDictionary *dic in value) {
            //赋值
            CityPriceModel *model = [CityPriceModel new];
            [model setValuesForKeysWithDictionary:dic];
            [self.discount addObject:model];
        }
    }
    if ([key isEqualToString:@"photos"]) {
        
        self.photos = [NSArray arrayWithArray:value];
    }
    
}

-(NSString *)description
{
    return [NSString stringWithFormat:@"photo:%@  hot_count: %@",_photos,_hot_city];
}

@end
