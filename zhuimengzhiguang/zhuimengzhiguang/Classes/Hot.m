//
//  Hot.m
//  zhuimengzhiguang
//
//  Created by 王建业 on 15/11/10.
//  Copyright © 2015年 王建业. All rights reserved.
//

#import "Hot.h"

@implementation Hot

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"id"]) {
        _hotID = value;
    }
}
@end
