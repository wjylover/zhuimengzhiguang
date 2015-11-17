//
//  CHTumblrMenuItemButton.m
//  zhuimengzhiguang
//
//  Created by 王建业 on 15/11/16.
//  Copyright © 2015年 王建业. All rights reserved.
//

#import "CHTumblrMenuItemButton.h"
#define CHTumblrMenuViewImageHeight 90
#define CHTumblrMenuViewTitleHeight 20
@implementation CHTumblrMenuItemButton
//{
//    UIImageView *iconView_;
//    UILabel *titleLabel_;
//}
- (id)initWithTitle:(NSString*)title andIcon:(UIImage*)icon andSelectedBlock:(CHTumblrMenuViewSelectedBlock)block
{
    self = [super init];
    if (self) {
        self.iconView_ = [UIImageView new];
        self.iconView_.image = icon;
        self.titleLabel_ = [UILabel new];
        self.titleLabel_.textAlignment = NSTextAlignmentCenter;
        self.titleLabel_.backgroundColor = [UIColor clearColor];
        self.titleLabel_.textColor = [UIColor whiteColor];
        self.titleLabel_.text = title;
        _selectedBlock = block;
        [self addSubview:self.iconView_];
        [self addSubview:self.titleLabel_];
    }
    return self;
}

- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    self.iconView_.frame = CGRectMake(0, 0, CHTumblrMenuViewImageHeight, CHTumblrMenuViewImageHeight);
    self.titleLabel_.frame = CGRectMake(0, CHTumblrMenuViewImageHeight, CHTumblrMenuViewImageHeight, CHTumblrMenuViewTitleHeight);
}


@end

