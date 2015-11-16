//
//  DesCityCell.m
//  zhuimengzhiguang
//
//  Created by lanou3g on 15/11/14.
//  Copyright © 2015年 王建业. All rights reserved.
//

#import "DesCityCell.h"
#import <UIImageView+WebCache.h>

@interface DesCityCell ()
//中文名 catename_cn
@property (weak, nonatomic) IBOutlet UILabel *cnname;
//英文名 catename_cn
@property (weak, nonatomic) IBOutlet UILabel *enname;
//去过的人数
@property (weak, nonatomic) IBOutlet UILabel *beenstr;
//代表景点
@property (weak, nonatomic) IBOutlet UILabel *representative;
//图片
@property (weak, nonatomic) IBOutlet UIImageView *picView;


@end

@implementation DesCityCell

-(void)setModel:(DesCityModel *)model
{
    //赋值cell
    self.cnname.text = model.catename;
    self.enname.text = model.catename_en;
    self.beenstr.text = model.beenstr;
    self.representative.text = model.representative;
    [self.picView sd_setImageWithURL:[NSURL URLWithString:model.photo] completed:nil];
}

- (void)awakeFromNib {
    // Initialization code
}

@end
