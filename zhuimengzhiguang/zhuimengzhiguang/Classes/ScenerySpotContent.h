//
//  ScenerySpotContent.h
//  zhuimengzhiguang
//
//  Created by 王建业 on 15/11/13.
//  Copyright © 2015年 王建业. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ScenerySpotContent : NSObject

@property (nonatomic, strong) NSString *address;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSString *cover;
@property (nonatomic, assign) NSInteger grade_people;
@property (nonatomic, strong) NSString *lat;
@property (nonatomic, strong) NSString *longitude;
@property (nonatomic, strong) NSString *phone;
@property (nonatomic, strong) NSArray *photo_list;
@property (nonatomic, strong) NSString *ticket;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, assign) CGFloat allstar;
@end
