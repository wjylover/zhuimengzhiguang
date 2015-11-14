//
//  pinLun.m
//  zhuimengzhiguang
//
//  Created by lanou3g on 15/11/12.
//  Copyright © 2015年 王建业. All rights reserved.
//

#import "pinLun.h"

@implementation pinLun

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"id"]) {
        NSLog(@"%@",key);
    }
    
}


- (NSString *)description
{
    return [NSString stringWithFormat:@"backContent=%@", _backContent];
}


@end
