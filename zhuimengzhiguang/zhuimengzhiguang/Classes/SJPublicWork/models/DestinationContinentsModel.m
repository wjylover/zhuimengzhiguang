//
//  DestinationContinentsModel.m
//  zhuimengzhiguang
//
//  Created by lanou3g on 15/11/9.
//  Copyright © 2015年 王建业. All rights reserved.
//

#import "DestinationContinentsModel.h"

@implementation DestinationContinentsModel

-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"id"]) {
        self.ID = value;
    }
}

//重写description方法
-(NSString *)description
{
    return [NSString stringWithFormat:@"cname:%@, ename:%@",_cnname,_enname];
}

@end
