//
//  WeatherTableViewCell.h
//  zhuimengzhiguang
//
//  Created by lanou3g on 15/11/16.
//  Copyright © 2015年 王建业. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Weather;

@interface WeatherTableViewCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UILabel *dataLabel;



@property (weak, nonatomic) IBOutlet UILabel *weatherLabel;

@property (weak, nonatomic) IBOutlet UILabel *temperatureLabel;

//天气对象
@property(nonatomic,strong)Weather *weather;

@end
