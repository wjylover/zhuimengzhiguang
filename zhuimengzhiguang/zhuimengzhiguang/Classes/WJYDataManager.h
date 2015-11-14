//
//  WJYDataManager.h
//  zhuimengzhiguang
//
//  Created by 王建业 on 15/11/9.
//  Copyright © 2015年 王建业. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ScenerySpotContent;
typedef void (^BackBlock) (void);
@interface WJYDataManager : NSObject

@property (nonatomic, strong) NSMutableArray *carouselImageArray;
@property (nonatomic, strong) NSMutableArray *cityListArray;
@property (nonatomic, strong) NSMutableArray *cityAllArray;
@property (nonatomic, strong) NSMutableArray *homeHotDataArray;
@property (nonatomic, strong) NSMutableArray *hotContentDataArray;
@property (nonatomic, strong) NSMutableArray *scenerySpotDataArray;
@property (nonatomic, strong) ScenerySpotContent *scenerySpotContent;
@property (nonatomic, copy) BackBlock carouselBlock;
@property (nonatomic, copy) BackBlock cityBlock;
@property (nonatomic, copy) BackBlock homeHotBlock;
@property (nonatomic, copy) BackBlock hotContentBlock;
@property (nonatomic, copy) BackBlock scenerySpotBlock;
@property (nonatomic, copy) BackBlock scenerySpotContentBlock;

+ (instancetype)sharedManager;
- (void)getCarouselImageData;
- (void)getHomeHotDataArrayWithCityID:(NSInteger)cityID Page:(NSInteger)page;
- (void)getHotContentDataArrayWithHotID:(NSInteger)hotID;
- (void)getCityList;
- (void)getScenicSpotDataArrayWithCityID:(NSInteger)cityID;
- (void)getScenicSpotContentArrayWithTypeID:(NSString *)typeID;
@end
