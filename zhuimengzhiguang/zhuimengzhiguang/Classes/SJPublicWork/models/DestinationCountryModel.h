//
//  DestinationCountryModel.h
//  zhuimengzhiguang
//
//  Created by lanou3g on 15/11/9.
//  Copyright © 2015年 王建业. All rights reserved.
//

#import "SJPublicObject.h"

@interface DestinationCountryModel : SJPublicObject

@property (nonatomic, copy) NSString *cnname;//中文名字
@property (nonatomic, copy) NSString *enname;//英文名字
@property (nonatomic, copy) NSString *count;//国家编号
@property (nonatomic, copy) NSString *flag;//未知参数
@property (nonatomic, copy) NSString *ID;//原本为id
@property (nonatomic, copy) NSString *label;//标注 '城市'
@property (nonatomic, copy) NSString *photo;//图片链接

@end
