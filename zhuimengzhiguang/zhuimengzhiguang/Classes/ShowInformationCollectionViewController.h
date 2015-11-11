//
//  ShowInformationCollectionViewController.h
//  zhuimengzhiguang
//
//  Created by lanou3g on 15/11/10.
//  Copyright © 2015年 王建业. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Mileage;

@interface ShowInformationCollectionViewController : UICollectionViewController

//接收选中的数据模型
@property(nonatomic,strong)Mileage *mileage;



@end
