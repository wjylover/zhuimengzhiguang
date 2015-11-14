//
//  CountryDesModel.h
//  zhuimengzhiguang
//
//  Created by lanou3g on 15/11/11.
//  Copyright © 2015年 王建业. All rights reserved.
//

#import "SJPublicObject.h"

@interface CountryDesModel : SJPublicObject

@property (nonatomic, copy) NSString *beento;
@property (nonatomic, copy) NSString *cnname;//中文名
@property (nonatomic, copy) NSString *enname;//英文名
@property (nonatomic, copy) NSString *entryCont;//一句话的详情
@property (nonatomic, assign) BOOL has_guide;
@property (nonatomic, assign) BOOL has_plan;
@property (nonatomic, assign) BOOL has_trip;
@property (nonatomic, strong) NSMutableArray *hot_city;//热门城市对象数组
//@property (nonatomic, strong) NSMutableArray *hot_mguide;
@property (nonatomic, strong) NSMutableArray *discount;//new_discount
@property (nonatomic, copy) NSString *ID;
@property (nonatomic, strong)NSArray *photos;//轮播图片
@property (nonatomic, copy) NSString *planto;

@end
