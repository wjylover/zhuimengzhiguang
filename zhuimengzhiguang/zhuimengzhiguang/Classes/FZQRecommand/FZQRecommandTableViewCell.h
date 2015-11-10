//
//  FZQRecommandTableViewCell.h
//  zhuimengzhiguang
//
//  Created by lanou3g on 15/11/9.
//  Copyright © 2015年 王建业. All rights reserved.
//

#import <UIKit/UIKit.h>
@class User;
@class Mileage;

@interface FZQRecommandTableViewCell : UITableViewCell


//所有视图属性

//图片
@property (weak, nonatomic) IBOutlet UIImageView *imgView;

//旅行日期
@property (weak, nonatomic) IBOutlet UILabel *dataLabel;

//旅行目的地
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;

//旅行者
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

//旅行目的
@property (weak, nonatomic) IBOutlet UILabel *destinationLabel;


//所需的数据模型
@property(nonatomic,strong) User *user;
@property(nonatomic,strong) Mileage *milage;



@end
