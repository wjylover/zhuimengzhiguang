//
//  DesCityRequestHandle.h
//  zhuimengzhiguang
//
//  Created by lanou3g on 15/11/14.
//  Copyright © 2015年 王建业. All rights reserved.
//

#import "SJPublicObject.h"

typedef void (^Result)();
@interface DesCityRequestHandle : SJPublicObject

//接收id
@property (nonatomic, copy) NSString *ID;
@property (nonatomic, copy) Result result;
@property (nonatomic, strong) NSArray *dataArray;

+(instancetype) shareDesCityRequestHandle;

-(void)requestHandleDesCityRequestHandle;


@end
