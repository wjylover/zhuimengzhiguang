//
//  MoreDesCityRequestHandle.h
//  zhuimengzhiguang
//
//  Created by lanou3g on 15/11/17.
//  Copyright © 2015年 王建业. All rights reserved.
//

#import "SJPublicObject.h"
typedef void (^Result)();
@interface MoreDesCityRequestHandle : SJPublicObject
@property (nonatomic, assign) NSInteger ID;
@property (nonatomic, copy) Result result;
@property (nonatomic,strong) NSArray *dataArray;

+(instancetype)shareMoreDesCityRequestHandle;

-(void)requestHandleWithMoreDesCityRequestHandle;

@end
