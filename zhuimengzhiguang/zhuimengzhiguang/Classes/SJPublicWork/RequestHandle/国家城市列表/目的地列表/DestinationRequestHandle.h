//
//  DestinationRequestHandle.h
//  zhuimengzhiguang
//
//  Created by lanou3g on 15/11/13.
//  Copyright © 2015年 王建业. All rights reserved.
//

#import "SJPublicObject.h"

//block
typedef void (^Result)();

@interface DestinationRequestHandle : SJPublicObject

//返回数组
@property (nonatomic, strong)NSArray *destinationArray;
//block
@property (nonatomic, copy) Result result;

//单例
+(instancetype)shareDDestinationRequestHandle;

//请求数据
-(void)destinationRequestHandle;

@end
