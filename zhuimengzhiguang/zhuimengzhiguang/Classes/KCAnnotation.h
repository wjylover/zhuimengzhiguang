//
//  KCAnnotation.h
//  豆瓣
//
//  Created by 王建业 on 15/9/28.
//  Copyright (c) 2015年 王建业. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
@interface KCAnnotation : NSObject<MKAnnotation>
@property (nonatomic) CLLocationCoordinate2D coordinate;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;
@end
