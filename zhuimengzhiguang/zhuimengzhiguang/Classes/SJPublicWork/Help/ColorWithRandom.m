//
//  ColorWithRandom.m
//  zhuimengzhiguang
//
//  Created by lanou3g on 15/11/19.
//  Copyright © 2015年 王建业. All rights reserved.
//

#import "ColorWithRandom.h"

@implementation ColorWithRandom

+(UIColor *)colorWithRandom
{
    CGFloat red = (arc4random()%256)/255.0;
    CGFloat green = (arc4random()%256)/255.0;
    CGFloat blue = (arc4random()%256)/255.0;
    CGFloat alpha = 1.0f;
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}

///*
// /** 普通闲置状态 */
//MJRefreshStateIdle = 1,
///** 松开就可以进行刷新的状态 */
//MJRefreshStatePulling,
///** 正在刷新中的状态 */
//MJRefreshStateRefreshing,
///** 即将刷新的状态 */
//MJRefreshStateWillRefresh,
///** 所有数据加载完毕，没有更多的数据了 */
//MJRefreshStateNoMoreData
// */

-(void)reFreshWithMJRefresh:(MJRefreshAutoGifFooter *)footer
{
    [footer setImages:nil forState:MJRefreshStateIdle];
    [footer setImages:nil forState:(MJRefreshStatePulling)];
    [footer setImages:nil forState:(MJRefreshStateWillRefresh)];
    [footer setImages:nil forState:(MJRefreshStateRefreshing)];
    
}

@end
