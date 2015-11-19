//
//  HomeCell.h
//  zhuimengzhiguang
//
//  Created by 王建业 on 15/11/10.
//  Copyright © 2015年 王建业. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *homeImage;
@property (weak, nonatomic) IBOutlet UILabel *homeLabel;
- (void)cellOnTableView:(UITableView *)tableView didScrollOnView:(UIView *)view;

@end
