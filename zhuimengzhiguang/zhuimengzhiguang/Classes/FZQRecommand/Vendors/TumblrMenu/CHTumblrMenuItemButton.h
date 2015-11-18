//
//  CHTumblrMenuItemButton.h
//  zhuimengzhiguang
//
//  Created by 王建业 on 15/11/16.
//  Copyright © 2015年 王建业. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CHTumblrMenuItemButton : UIControl
- (id)initWithTitle:(NSString*)title andIcon:(UIImage*)icon andSelectedBlock:(CHTumblrMenuViewSelectedBlock)block;
@property(nonatomic,copy)CHTumblrMenuViewSelectedBlock selectedBlock;

@property (nonatomic, strong) UIImageView *iconView_;
@property (nonatomic, strong) UILabel *titleLabel_;
@end
