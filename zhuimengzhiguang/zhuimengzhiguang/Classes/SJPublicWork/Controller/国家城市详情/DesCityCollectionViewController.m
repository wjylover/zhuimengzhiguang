//
//  DesCityCollectionViewController.m
//  zhuimengzhiguang
//
//  Created by lanou3g on 15/11/13.
//  Copyright © 2015年 王建业. All rights reserved.
//

#import "DesCityCollectionViewController.h"
#import "MoreDesCityRequestHandle.h"
#import "GoodLocalRequestHandle.h"
#import "AboutCityViewController.h"
#import "DesCityRequestHandle.h"
#import "DesCityCell.h"
#import "ColorWithRandom.h"


@interface DesCityCollectionViewController ()<MONActivityIndicatorViewDelegate>

@property (nonatomic,strong) NSArray *array;

@end

@implementation DesCityCollectionViewController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //注意  注意  注意: 重要的事情要说三遍  --->>> 设置的是collectionView的背景,不是self.view   要不然   界面会一直是黑色的
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    //布局
    [self layoutCollectionView];
    //网络请求
    [self getValuesWithRequest];

}



//布局
-(void)layoutCollectionView
{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    //设置item大小
    flowLayout.itemSize = CGSizeMake(self.collectionView.bounds.size.width/2 - 50, 130);
    //设置间距
    flowLayout.sectionInset = UIEdgeInsetsMake(30, 50, 10, 30);
    self.collectionView.collectionViewLayout = flowLayout;
    //设置滚动条是否显示
    self.collectionView.showsVerticalScrollIndicator = NO;
    
    //注册cell
    [self.collectionView registerNib:[UINib nibWithNibName:@"DesCityCell" bundle:nil] forCellWithReuseIdentifier:@"desCityCell"];
}

//网络请求
-(void)getValuesWithRequest
{
    MONActivityIndicatorView *indicatorView = [[MONActivityIndicatorView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    [self layoutIndicatorView:indicatorView];
    [self.view addSubview:indicatorView];
    [indicatorView startAnimating];
    
    [[DesCityRequestHandle shareDesCityRequestHandle]requestHandleDesCityRequestHandle];
    [DesCityRequestHandle shareDesCityRequestHandle].result = ^(){
        //将对象数组中的数据给array
        self.array = [NSArray arrayWithArray:[DesCityRequestHandle shareDesCityRequestHandle].dataArray];
        //刷新
        [self.collectionView reloadData];
        [indicatorView stopAnimating];
    };
}

//动画设置
-(void)layoutIndicatorView:(MONActivityIndicatorView *)indicatorView
{
    indicatorView.numberOfCircles = 3;
    indicatorView.radius = 20;
    indicatorView.internalSpacing = 3;
    indicatorView.duration = 0.5;
    indicatorView.delay = 0.5;
    indicatorView.center = self.view.center;
    
    indicatorView.delegate = self;
}

-(UIColor *)activityIndicatorView:(MONActivityIndicatorView *)activityIndicatorView circleBackgroundColorAtIndex:(NSUInteger)index
{
    return [ColorWithRandom colorWithRandom];
}

//设置navigationBar的渐变颜色
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    UIColor *color = [UIColor colorWithRed:0.576 green:0.545 blue:1.000 alpha:1.000];
    
    //将collectionView的高度的偏移量赋给  offset
    CGFloat offset = self.collectionView.contentOffset.y;
    //判断
    if (offset < 0) {
        self.navigationController.navigationBar.backgroundColor = [color colorWithAlphaComponent:0];
    }else{
        CGFloat alpha = 1 - ((self.collectionView.bounds.size.height - 500 - offset)/100);
        self.navigationController.navigationBar.backgroundColor = [color colorWithAlphaComponent:alpha];
    }
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {

    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return self.array.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {

    DesCityCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"desCityCell" forIndexPath:indexPath];
    
    DesCityModel *model = [DesCityModel new];
    model = self.array[indexPath.item];
    cell.model = model;
    
    
    return cell;
}

//设置item的大小
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(self.collectionView.bounds.size.width/2 - 60, 180);
}

//点击item
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    //将国家的id传递出去
    DesCityModel *model = [[DesCityModel alloc]init];
    model = self.array[indexPath.item];
    [MoreDesCityRequestHandle shareMoreDesCityRequestHandle].ID = model.ID;
    
    [GoodLocalRequestHandle shareGoodLocalRequestHandle].ID = model.ID;
    
    AboutCityViewController *aboutVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"aboutVC"];
    
    [self.navigationController pushViewController:aboutVC animated:YES];
}


@end
