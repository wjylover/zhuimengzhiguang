//
//  Loglist.m
//  zhuimengzhiguang
//
//  Created by lanou3g on 15/11/10.
//  Copyright © 2015年 王建业. All rights reserved.
//

#import "Loglist.h"

@implementation Loglist


-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"id"]) {
        NSLog(@"%@",key);
    }
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"logId=%ld", _logId];
}

@end
