//
//  MoreDesCityCell.m
//  zhuimengzhiguang
//
//  Created by lanou3g on 15/11/17.
//  Copyright © 2015年 王建业. All rights reserved.
//

#import "MoreDesCityCell.h"
#import <UIImageView+WebCache.h>

@interface MoreDesCityCell ()

@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UIImageView *picView;


@end

@implementation MoreDesCityCell

-(void)setModel:(MoreDesCityModel *)model
{
    self.title.text = model.title;
    [self.picView sd_setImageWithURL:[NSURL URLWithString:model.photo] placeholderImage:nil];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
