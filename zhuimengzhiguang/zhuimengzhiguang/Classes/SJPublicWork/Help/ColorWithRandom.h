//
//  ColorWithRandom.h
//  zhuimengzhiguang
//
//  Created by lanou3g on 15/11/19.
//  Copyright © 2015年 王建业. All rights reserved.
//

#import "SJPublicObject.h"

@interface ColorWithRandom : SJPublicObject

+(UIColor *)colorWithRandom;

-(void)reFreshWithMJRefresh:(MJRefreshAutoGifFooter *)footer;

@end
