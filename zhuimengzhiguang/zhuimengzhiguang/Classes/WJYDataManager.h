//
//  WJYDataManager.h
//  zhuimengzhiguang
//
//  Created by 王建业 on 15/11/9.
//  Copyright © 2015年 王建业. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^BackBlock) (void);
@interface WJYDataManager : NSObject

@property (nonatomic, strong) NSMutableArray *carouselImageArray;
@property (nonatomic, copy) BackBlock carouselBlock;
+ (instancetype)sharedManager;
- (void)getCarouselImageData;
@end
