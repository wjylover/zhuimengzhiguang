//
//  CityCell.m
//  zhuimengzhiguang
//
//  Created by lanou3g on 15/11/12.
//  Copyright © 2015年 王建业. All rights reserved.
//

#import "CityCell.h"
#import <UIImageView+WebCache.h>

@interface CityCell ()

@property (weak, nonatomic) IBOutlet UILabel *cnname;//中文名
@property (weak, nonatomic) IBOutlet UILabel *cityEname;//英文名
@property (weak, nonatomic) IBOutlet UIImageView *picView;//图片

@end

@implementation CityCell

-(void)setModel:(CityModel *)model
{
    self.cnname.text = [model valueForKey:@"cnname"];
    self.cityEname.text = [model valueForKey:@"enname"];
    [self.picView sd_setImageWithURL:[NSURL URLWithString:[model valueForKey:@"photo"]] completed:nil];
}

- (void)awakeFromNib {
    // Initialization code

    
}

@end
