//
//  ScenerySpot.m
//  zhuimengzhiguang
//
//  Created by 王建业 on 15/11/13.
//  Copyright © 2015年 王建业. All rights reserved.
//

#import "ScenerySpot.h"

@implementation ScenerySpot

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"id"]) {
        _typeID = value;
    }
}
@end
