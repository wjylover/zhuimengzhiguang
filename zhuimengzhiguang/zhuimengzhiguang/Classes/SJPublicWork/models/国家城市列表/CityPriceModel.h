//
//  CityPriceModel.h
//  zhuimengzhiguang
//
//  Created by lanou3g on 15/11/12.
//  Copyright © 2015年 王建业. All rights reserved.
//

#import "SJPublicObject.h"

@interface CityPriceModel : SJPublicObject

@property (nonatomic, copy) NSString *expire_date;//打折的截止时间
@property (nonatomic, copy) NSString *ID;//原本为id
@property (nonatomic, copy) NSString *photo;//图片链接
@property (nonatomic, copy) NSString *price;//价格
@property (nonatomic, copy) NSString *priceoff;//折扣
@property (nonatomic, copy) NSString *title;//标题

@end
