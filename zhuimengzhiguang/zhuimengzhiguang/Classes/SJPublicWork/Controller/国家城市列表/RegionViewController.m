//
//  RegionViewController.m
//  zhuimengzhiguang
//
//  Created by lanou3g on 15/11/12.
//  Copyright © 2015年 王建业. All rights reserved.
//

#import "RegionViewController.h"
//轮播图
#import <SDCycleScrollView.h>

#import "CityRequestHandle.h"
#import "CityCell.h"
#import "CityPriceCell.h"
#import "CountryDesModel.h"
#import "CityPriceModel.h"
#import "DesCityPriceTableViewController.h"
#import "DesCityCollectionViewController.h"
#import "DesCityRequestHandle.h"
#import "ColorWithRandom.h"

//城市详情界面
#import "AboutCityViewController.h"

#import "GoodLocalRequestHandle.h"

@interface RegionViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UITableViewDataSource,UITableViewDelegate,MONActivityIndicatorViewDelegate>
//轮播图
@property (weak, nonatomic) IBOutlet SDCycleScrollView *cycleScrollView;
//collectionView的背景
@property (weak, nonatomic) IBOutlet UIView *viewBG;
//tableView
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
//最大的背景 scrollView
@property (weak, nonatomic) IBOutlet UIScrollView *scroView;
//最大的内容视图
@property (weak, nonatomic) IBOutlet UIView *maxViewBCG;
//更多热门城市
@property (weak, nonatomic) IBOutlet UIButton *moreFierAction;
//超值自由行
@property (weak, nonatomic) IBOutlet UIButton *freeAction;
//collectionView的背景
@property (weak, nonatomic) IBOutlet UIView *collectionBackGround;


@end

@implementation RegionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //轮播图
    [self layoutViewShuff];
    //设置热门城市
    [self layoutCity];
    //设置tableView
    [self layoutTableView];
    
}
//轮播图
-(void)layoutViewShuff
{
    MONActivityIndicatorView *indicatorView = [[MONActivityIndicatorView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    
    [self.view addSubview:indicatorView];
    [self layoutIndicatorView:indicatorView];
    [indicatorView startAnimating];
    
    //网络数据的请求
    [[CityRequestHandle shareCityReqeustHandle]CityWithRequestHandle];
    
    //刷新传值
    
    [CityRequestHandle shareCityReqeustHandle].result = ^(){
        
        //因为 block语法块先执行大括号外面的,所以,如果在block外面赋值轮播图是没有值的
        
        //如果在外面赋值 会导致在model数据里面 不会走 .m 文明间里面的方法
        
        //因为数据对象数组里面就一个数据, 所以 直接取 0 就好
        
        CountryDesModel *model = [CityRequestHandle shareCityReqeustHandle].dataArray[0];
        
        //将网络加载图片的接口给数组
        
        NSArray *array = [NSArray arrayWithArray:model.photos];
        
        self.cycleScrollView.imageURLStringsGroup = array;
        
        [self.collectionView reloadData];
        [self.tableView reloadData];
        [indicatorView stopAnimating];
        self.collectionBackGround.backgroundColor = [UIColor colorWithRed:0.556 green:0.562 blue:1.000 alpha:1.000];
};
    
    //设置pageControl为不显示
    _cycleScrollView.showPageControl = NO;
    

}
//加载动画设置
-(void)layoutIndicatorView:(MONActivityIndicatorView *)indicatorView
{
    indicatorView.numberOfCircles = 5;
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

//设置热门城市
-(void)layoutCity
{
    //设置UICollectionView
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    //设置距离
    flowLayout.sectionInset = UIEdgeInsetsMake(20, 20, 20, 20);
    //设置是否能滑动
    self.collectionView.scrollEnabled = NO;
    _collectionView.collectionViewLayout = flowLayout;
    //代理
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    //背景
    _collectionView.backgroundColor = [UIColor whiteColor];
    //注册 cell
    [_collectionView registerNib:[UINib nibWithNibName:@"CityCell" bundle:nil] forCellWithReuseIdentifier:@"collectionCell"];
}
//设置tableView
-(void)layoutTableView
{
    //注册cell
    [self.tableView registerNib:[UINib nibWithNibName:@"CityPriceCell" bundle:nil] forCellReuseIdentifier:@"cityPriceCell"];
    //代理
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
}

#pragma mark -- UICollectionViewDataSource  UICollectionViewDelegate --
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    CountryDesModel *model = [CountryDesModel new];
    //赋值给数据模型
    model = [[[CityRequestHandle shareCityReqeustHandle] dataArray] firstObject];
    //判断 数据是否为空
    if (model.discount.count == 0) {
        //关闭滑动
        self.scroView.scrollEnabled = NO;
        //将button隐藏
        self.freeAction.hidden = YES;
    }else{
        self.freeAction.hidden = NO;
        //控制滚动视图能否滑动
        self.scroView.scrollEnabled = YES;
        //控制滚动视图能否超出内容边缘再弹回
        self.scroView.bounces = NO;
        self.scroView.showsVerticalScrollIndicator = NO;
        
    }
    
    //如果热门城市为空 就将点击更多的button隐藏
    if (model.hot_city.count == 0) {
        
        self.moreFierAction.hidden = YES;
        
        return 1;
    }else{
        
        self.moreFierAction.hidden = NO;
        //返回热门国家的个数
        return model.hot_city.count;

    }
        
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CityCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"collectionCell" forIndexPath:indexPath];
    
    CountryDesModel *model = [CountryDesModel new];
    model = [CityRequestHandle shareCityReqeustHandle].dataArray.firstObject;
    
    if (model.hot_city.count == 0) {
        return cell;
    }else{
        CityModel *cityModel = [CityModel new];
        cityModel = model.hot_city[indexPath.row];
        cell.model = cityModel;
        return cell;
    }
    
}

//设置item的大小
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CountryDesModel *model = [CountryDesModel new];
    //赋值给数据模型
    model = [[[CityRequestHandle shareCityReqeustHandle] dataArray] firstObject];
    
    //根据item的个数来返回大小
    if (model.hot_city.count == 1 || model.hot_city.count == 0 ) {
        return CGSizeMake(self.collectionView.bounds.size.width - 50, self.collectionView.bounds.size.height - 40);
    }else if (model.hot_city.count == 2){
        return CGSizeMake(self.collectionView.bounds.size.width/2 - 40, self.collectionView.bounds.size.height - 40);
    }else {
        return CGSizeMake(self.collectionView.bounds.size.width/2 - 25, self.collectionView.bounds.size.height/2 - 20);
    }
    
}


#pragma mark  -- UITableViewDataSource  UITableViewDelegate --
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    CountryDesModel *model = [CountryDesModel new];
    model = [[[CityRequestHandle shareCityReqeustHandle] dataArray] firstObject];
    
    return model.discount.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CityPriceCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cityPriceCell" forIndexPath:indexPath];
    
    CountryDesModel *model = [CountryDesModel new];
    model = [CityRequestHandle shareCityReqeustHandle].dataArray[0];
    
    CityPriceModel *priceModel = model.discount[indexPath.row];
    
    cell.model = priceModel;
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}


//更多热门城市
- (IBAction)moreCity:(UIButton *)sender {
    
    
    DesCityCollectionViewController *desCity = [[DesCityCollectionViewController alloc]init];
    desCity = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"desCity"];
    [self.navigationController pushViewController:desCity animated:YES];
    
}
//超值自由行
- (IBAction)valueFreeLineAction:(UIButton *)sender {
    
    DesCityPriceTableViewController *desCityPrice = [[DesCityPriceTableViewController alloc]init];
    desCityPrice = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"desCityPrice"];
    [self.navigationController pushViewController:desCityPrice animated:YES];
}




@end
