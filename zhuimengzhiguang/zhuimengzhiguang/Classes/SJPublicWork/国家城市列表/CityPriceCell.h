//
//  CityPriceCell.h
//  zhuimengzhiguang
//
//  Created by lanou3g on 15/11/12.
//  Copyright © 2015年 王建业. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CityPriceModel.h"

@interface CityPriceCell : UITableViewCell

@property (nonatomic, strong) CityPriceModel *model;
//折扣价
@property (weak, nonatomic) IBOutlet UILabel *price;

@end
