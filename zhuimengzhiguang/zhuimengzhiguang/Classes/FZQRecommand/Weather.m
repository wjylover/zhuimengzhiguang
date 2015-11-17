//
//  Weather.m
//  zhuimengzhiguang
//
//  Created by lanou3g on 15/11/16.
//  Copyright © 2015年 王建业. All rights reserved.
//

#import "Weather.h"

@implementation Weather


-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"id"]) {
        NSLog(@"%@",key);
       
    }
}


- (NSString *)description
{
    return [NSString stringWithFormat:@"date=%@", _date];
}
@end
