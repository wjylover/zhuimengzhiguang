//
//  CityRequestHandle.h
//  zhuimengzhiguang
//
//  Created by lanou3g on 15/11/11.
//  Copyright © 2015年 王建业. All rights reserved.
//

#import "SJPublicObject.h"

typedef void (^Result)();
@interface CityRequestHandle : SJPublicObject

//block
@property (nonatomic, copy) Result result;
//返回数组
@property (nonatomic, strong) NSArray *dataArray;
//接收传递来的国家的id
@property (nonatomic, copy) NSString *ID;

//单例
+(instancetype)shareCityReqeustHandle;
//网络请求
-(void)CityWithRequestHandle;

@end
