//
//  MoreDesCityModel.m
//  zhuimengzhiguang
//
//  Created by lanou3g on 15/11/17.
//  Copyright © 2015年 王建业. All rights reserved.
//

#import "MoreDesCityModel.h"

@implementation MoreDesCityModel

-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"id"]) {
        self.ID = value;
    }
}

@end
