//
//  Mileage.h
//  zhuimengzhiguang
//
//  Created by lanou3g on 15/11/9.
//  Copyright © 2015年 王建业. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Mileage : NSObject


//属性
//出发日期
@property(nonatomic,copy) NSString *packDate;
//活动内容
@property(nonatomic,copy) NSString *content;
//图片url
@property(nonatomic,strong) NSArray *imageUrls;
//参加id
@property(nonatomic,assign) NSInteger journeyId;
//旅行开始地方
@property(nonatomic,copy) NSString *travelStart;
//旅行结束地方
@property(nonatomic,copy) NSString *travelEnd;
//旅行时长
@property(nonatomic,copy) NSString *days;


//旅行内容
@property(nonatomic,copy)NSString *travelContent;
//距离
@property(nonatomic,copy)NSString *distance;








@end
