//
//  pinLunTableViewCell.m
//  zhuimengzhiguang
//
//  Created by lanou3g on 15/11/12.
//  Copyright © 2015年 王建业. All rights reserved.
//

#import "pinLunTableViewCell.h"

@implementation pinLunTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}



-(void)setPinlun:(pinLun *)pinlun{
    self.nameLabel.text = pinlun.userName;
    self.timeLabel.text = pinlun.commentsTime;
    self.contentLabel.text = pinlun.backContent;
    
    [self.photoImgView sd_setImageWithURL:[NSURL URLWithString:pinlun.photoUrl] placeholderImage:[UIImage imageNamed:@"placeimage2.jpg"]];
}

@end
