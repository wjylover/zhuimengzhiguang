//
//  WeatherTableViewCell.m
//  zhuimengzhiguang
//
//  Created by lanou3g on 15/11/16.
//  Copyright © 2015年 王建业. All rights reserved.
//

#import "WeatherTableViewCell.h"

@implementation WeatherTableViewCell



-(void)setWeather:(Weather *)weather{
    
    _dataLabel.text = weather.date;
    _weatherLabel.text = weather.type;
    NSString *lowString = [weather.low substringFromIndex:2];
    NSString *highString = [weather.high substringFromIndex:2];
    
    NSString * highAndLowTemperature = [NSString stringWithFormat:@"%@~%@",lowString,highString];
    _temperatureLabel.text = highAndLowTemperature;
}







@end
