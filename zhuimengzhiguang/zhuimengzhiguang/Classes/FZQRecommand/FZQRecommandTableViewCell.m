//
//  FZQRecommandTableViewCell.m
//  zhuimengzhiguang
//
//  Created by lanou3g on 15/11/9.
//  Copyright © 2015年 王建业. All rights reserved.
//

#import "FZQRecommandTableViewCell.h"

@implementation FZQRecommandTableViewCell



//重写setter方法，将数据传给所有视图
-(void)setUser:(User *)user{
    _nameLabel.text = user.userName;
}

-(void)setMilage:(Mileage *)milage{
    NSString *urlString = milage.imageUrls.firstObject;
    [_imgView sd_setImageWithURL:[NSURL URLWithString:urlString]];
    
    _dataLabel.text = [NSString stringWithFormat:@"%@/%@天",milage.packDate,milage.days];
    
    _addressLabel.text = [NSString stringWithFormat:@"%@-%@",milage.travelStart,milage.travelEnd];
    
    _destinationLabel.text = milage.content;
    
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
