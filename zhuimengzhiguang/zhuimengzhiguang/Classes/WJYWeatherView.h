//
//  WJYWeatherView.h
//  zhuimengzhiguang
//
//  Created by 王建业 on 15/11/17.
//  Copyright © 2015年 王建业. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WJYWeatherView : UIView
@property (strong, nonatomic) IBOutlet UIImageView *typeImage;
@property (strong, nonatomic) IBOutlet UILabel *typeLabel;
@property (strong, nonatomic) IBOutlet UILabel *dayLabel;
@property (strong, nonatomic) IBOutlet UILabel *windLabel;
@property (strong, nonatomic) IBOutlet UILabel *weekLabel;
@property (strong, nonatomic) IBOutlet UILabel *tempLabel;

@property (strong, nonatomic) IBOutlet UILabel *cityLabel;
@end
