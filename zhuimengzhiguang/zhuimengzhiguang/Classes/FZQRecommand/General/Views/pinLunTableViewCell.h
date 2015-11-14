//
//  pinLunTableViewCell.h
//  zhuimengzhiguang
//
//  Created by lanou3g on 15/11/12.
//  Copyright © 2015年 王建业. All rights reserved.
//

#import <UIKit/UIKit.h>
@class pinLun;

@interface pinLunTableViewCell : UITableViewCell

//头像
@property (weak, nonatomic) IBOutlet UIImageView *photoImgView;

//名字
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
//评论时间
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

//回复内容
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

//数据模型
@property(nonatomic,strong)pinLun *pinlun;

@end
