//
//  destinationCell.m
//  zhuimengzhiguang
//
//  Created by lanou3g on 15/11/10.
//  Copyright © 2015年 王建业. All rights reserved.
//

#import "destinationCell.h"

@interface DestinationCell ()
//背景图片
@property (weak, nonatomic) IBOutlet UIImageView *picView;
//中文名
@property (weak, nonatomic) IBOutlet UILabel *cnnameLabel;
//英文名
@property (weak, nonatomic) IBOutlet UILabel *ennameLabel;

@end

@implementation DestinationCell

-(void)setModel:(DestinationCountryModel *)model
{
    //赋值cell
    self.cnnameLabel.text = model.cnname;
    self.ennameLabel.text = model.enname;
    [self.picView sd_setImageWithURL:[NSURL URLWithString:model.photo] placeholderImage:[UIImage imageNamed:@"12"] completed:nil];
}

- (void)awakeFromNib {
    // Initialization code
}

@end
