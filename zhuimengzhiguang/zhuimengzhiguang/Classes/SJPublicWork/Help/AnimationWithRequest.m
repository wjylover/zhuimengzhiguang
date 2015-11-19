//
//  AnimationWithRequest.m
//  zhuimengzhiguang
//
//  Created by lanou3g on 15/11/19.
//  Copyright © 2015年 王建业. All rights reserved.
//

#import "AnimationWithRequest.h"
#import "ColorWithRandom.h"

@interface AnimationWithRequest ()<MONActivityIndicatorViewDelegate>

@end

@implementation AnimationWithRequest


//加载动画设置
-(void)layoutIndicatorView:(MONActivityIndicatorView *)indicatorView
{
    indicatorView.numberOfCircles = 5;
    indicatorView.radius = 20;
    indicatorView.internalSpacing = 3;
    indicatorView.duration = 0.5;
    indicatorView.delay = 0.5;
        
}


@end
