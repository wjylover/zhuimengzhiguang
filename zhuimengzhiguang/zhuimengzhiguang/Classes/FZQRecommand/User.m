//
//  User.m
//  zhuimengzhiguang
//
//  Created by lanou3g on 15/11/9.
//  Copyright © 2015年 王建业. All rights reserved.
//

#import "User.h"

@implementation User


-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"id"]) {
        NSLog(@"%@",key);
    }
}

//校验
- (NSString *)description
{
    return [NSString stringWithFormat:@"userId=%ld", _userId];
}

@end
