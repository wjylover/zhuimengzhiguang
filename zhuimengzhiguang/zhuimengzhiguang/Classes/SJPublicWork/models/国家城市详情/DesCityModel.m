//
//  DesCityModel.m
//  zhuimengzhiguang
//
//  Created by lanou3g on 15/11/14.
//  Copyright © 2015年 王建业. All rights reserved.
//

#import "DesCityModel.h"

@implementation DesCityModel

-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"id"]) {
        self.ID = value;
    }
}

@end
