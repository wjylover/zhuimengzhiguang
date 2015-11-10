//
//  WJYHomeViewController.m
//  zhuimengzhiguang
//
//  Created by 王建业 on 15/11/9.
//  Copyright © 2015年 王建业. All rights reserved.
//

#import "WJYHomeViewController.h"
#import "WJYDataManager.h"
#import "HotCity.h"
#import <SDCycleScrollView.h>

@interface WJYHomeViewController ()<SDCycleScrollViewDelegate>
// 轮播图控件
@property (weak, nonatomic) IBOutlet SDCycleScrollView *cycleScrollView;
// 轮播图数据数组
@property (nonatomic, strong) NSMutableArray *carouselImageArray;
@property (nonatomic, strong) NSMutableArray *carouselTextArray;
@end

@implementation WJYHomeViewController

- (void)viewWillAppear:(BOOL)animated
{
    // 加载轮播图数据
    [[WJYDataManager sharedManager] getCarouselImageData];
    [WJYDataManager sharedManager].carouselBlock = ^(){
        self.carouselImageArray = [NSMutableArray arrayWithCapacity:4];
        self.carouselTextArray = [NSMutableArray arrayWithCapacity:4];
        for (HotCity *hotCity in [WJYDataManager sharedManager].carouselImageArray) {
            [self.carouselImageArray addObject:hotCity.photo];
            [self.carouselTextArray addObject:hotCity.cnname];
            _cycleScrollView.imageURLStringsGroup = _carouselImageArray;
            _cycleScrollView.titlesGroup = _carouselTextArray;
        }
    };
}

- (void)loadData
{
    

}

- (void)viewDidLoad {
    [super viewDidLoad];

    // 采用网络图片实现
    _cycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
    _cycleScrollView.delegate = self;
    //_cycleScrollView.dotColor = [UIColor yellowColor]; // 自定义分页控件小圆标颜色
    _cycleScrollView.placeholderImage = [UIImage imageNamed:@"placeholder"];
    [self.view addSubview:_cycleScrollView];
    
}
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    NSLog(@"---点击了第%ld张图片", index);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
