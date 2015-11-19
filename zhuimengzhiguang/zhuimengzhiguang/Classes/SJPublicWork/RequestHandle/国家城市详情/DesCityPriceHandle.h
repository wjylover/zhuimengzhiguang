//
//  DesCityPriceHandle.h
//  zhuimengzhiguang
//
//  Created by lanou3g on 15/11/14.
//  Copyright © 2015年 王建业. All rights reserved.
//

#import "SJPublicObject.h"

typedef void (^Result)();
@interface DesCityPriceHandle : SJPublicObject

@property (nonatomic, assign) NSInteger ID;
@property (nonatomic, copy) NSString *count;

@property (nonatomic, copy) Result result;
@property (nonatomic, strong) NSMutableArray *dataArray;

+(instancetype)shareDesCityPriceHandle;

-(void)requestDesCityPriceHandle;

@end
