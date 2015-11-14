//
//  CityModel.h
//  zhuimengzhiguang
//
//  Created by lanou3g on 15/11/11.
//  Copyright © 2015年 王建业. All rights reserved.
//

#import "SJPublicObject.h"

@interface CityModel : SJPublicObject

@property (nonatomic, copy) NSString *cnname;//中文名称
@property (nonatomic, copy) NSString *enname;//英文名称
@property (nonatomic, copy) NSString *ID;//原本为id
@property (nonatomic, copy) NSString *photo;//图片列表

@end
