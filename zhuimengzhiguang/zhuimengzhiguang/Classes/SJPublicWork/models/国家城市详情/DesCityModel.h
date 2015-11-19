//
//  DesCityModel.h
//  zhuimengzhiguang
//
//  Created by lanou3g on 15/11/14.
//  Copyright © 2015年 王建业. All rights reserved.
//

#import "SJPublicObject.h"

@interface DesCityModel : SJPublicObject

@property (nonatomic, copy) NSString *beennumber;//人数
@property (nonatomic, copy) NSString *beenstr;//95875人去过
@property (nonatomic, copy) NSString *catename;//地名 -->曼谷
@property (nonatomic, copy) NSString *catename_en;//英文名
@property (nonatomic, assign) NSInteger ID;//原本为id
@property (nonatomic, assign) BOOL isguide;
@property (nonatomic, assign) BOOL ishot;
@property (nonatomic, copy) NSString *lat; //未知,例如: 8.066667
@property (nonatomic, copy) NSString *lng; //未知,例如: 98.916664
@property (nonatomic, copy) NSString *representative;//代表景点
@property (nonatomic, copy) NSString *photo;//图片


@end
