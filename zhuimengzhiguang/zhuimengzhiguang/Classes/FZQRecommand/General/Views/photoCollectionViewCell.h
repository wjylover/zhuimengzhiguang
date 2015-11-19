//
//  photoCollectionViewCell.h
//  zhuimengzhiguang
//
//  Created by lanou3g on 15/11/19.
//  Copyright © 2015年 王建业. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface photoCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *bigPhotoImg;


@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@property (weak, nonatomic) IBOutlet UIButton *saveBtn;

@end
