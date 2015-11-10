//
//  RequestHandle.h
//  zhuimengzhiguang
//
//  Created by lanou3g on 15/11/9.
//  Copyright © 2015年 王建业. All rights reserved.
//

#import "SJPublicObject.h"

@interface RequestHandle : SJPublicObject
//接收七大洲的数组
@property (nonatomic, strong) NSArray *destinaArray;
//接收国家的数组
@property (nonatomic, strong) NSArray *countriesArray;

//单例
+(instancetype)sharedRequestHandle;

//目的地列表界面的网络请求
-(void)destinationWithUrlString;

@end
