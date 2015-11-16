//
//  WJYCoreDataManager.h
//  zhuimengzhiguang
//
//  Created by 王建业 on 15/11/16.
//  Copyright © 2015年 王建业. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Collect;

@interface WJYCoreDataManager : NSObject
+ (instancetype)sharedManager;
- (void)addCollect:(NSString *)typeID;
- (void)deleteCollectTabel;
- (NSArray *)getAllCollect;
- (Collect *)getCollectWithTypeID:(NSString *)typeID;

@end
