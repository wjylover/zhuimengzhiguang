//
//  GoodLocalCellTableViewCell.m
//  zhuimengzhiguang
//
//  Created by lanou3g on 15/11/18.
//  Copyright © 2015年 王建业. All rights reserved.
//

#import "GoodLocalCellTableViewCell.h"
#import <UIImageView+WebCache.h>

@interface GoodLocalCellTableViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *picView;

@property (weak, nonatomic) IBOutlet UILabel *title;

@end

@implementation GoodLocalCellTableViewCell

-(void)setModel:(GoodLocalCityModel *)model
{
    [self.picView sd_setImageWithURL:[NSURL URLWithString:model.photo] placeholderImage:nil];
    self.title.text = model.title;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
