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
    if ([key isEqualToString:@"country"]) {
        
        self.country = [NSMutableArray array];
        
        for (NSDictionary *dic in value) {
            DestinationCountryModel *model = [DestinationCountryModel new];
            [model setValuesForKeysWithDictionary:dic];
            [self.country addObject:dic];
        }
    }
    if ([key isEqualToString:@"hot_country"]) {
        self.hot_country = [NSMutableArray array];
        for (NSDictionary *dic in value) {
            DestinationCountryModel *model = [DestinationCountryModel new];
            
        }
    }
}

//重写description方法
-(NSString *)description
{
    return [NSString stringWithFormat:@"cname:%@, ename:%@",_cnname,_enname];
}

@end
