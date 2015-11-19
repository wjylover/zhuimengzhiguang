//
//  CityPriceCell.m
//  zhuimengzhiguang
//
//  Created by lanou3g on 15/11/12.
//  Copyright © 2015年 王建业. All rights reserved.
//

#import "CityPriceCell.h"
#import <UIImageView+WebCache.h>

@interface CityPriceCell ()

//标题
@property (weak, nonatomic) IBOutlet UILabel *title;
//打折
@property (weak, nonatomic) IBOutlet UILabel *priceoff;

//图片
@property (weak, nonatomic) IBOutlet UIImageView *picView;


@end

@implementation CityPriceCell

-(void)setModel:(CityPriceModel *)model
{
    self.title.text = model.title;
    
    self.priceoff.text = model.priceoff;
    
    //截取价格
    NSString *first = [model.price substringFromIndex:4];
    NSString *last = nil;
    if (first.length == 10) {
        last = [first substringToIndex:3];
    }else if(first.length == 11){
        last = [first substringToIndex:4];
    }else if (first.length == 12){
        last = [first substringToIndex:5];
    }else{
        last = [first substringToIndex:4];
    }
    self.price.text = [NSString stringWithFormat:@"%@元起",last];
    
    [self.picView sd_setImageWithURL:[NSURL URLWithString:model.photo] completed:nil];
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
