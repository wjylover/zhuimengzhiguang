//
//  GoodLocalCityModel.h
//  zhuimengzhiguang
//
//  Created by lanou3g on 15/11/18.
//  Copyright © 2015年 王建业. All rights reserved.
//

#import "SJPublicObject.h"

@interface GoodLocalCityModel : SJPublicObject

@property (nonatomic, copy) NSString *ID;//原本为id
@property (nonatomic, copy) NSString *photo;//图片
@property (nonatomic, copy) NSString *price;//价格
@property (nonatomic, copy) NSString *priceoff;//打折
@property (nonatomic, copy) NSString *title;//标题

@end
