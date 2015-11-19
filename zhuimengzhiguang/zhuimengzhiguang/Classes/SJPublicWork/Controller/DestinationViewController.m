//
//  DestinationViewController.m
//  zhuimengzhiguang
//
//  Created by lanou3g on 15/11/9.
//  Copyright © 2015年 王建业. All rights reserved.
//

#import "DestinationViewController.h"
#import "DestinationContinentsModel.h"
#import "RegionViewController.h"
#import "DestinationCountryModel.h"
#import "DestinationCell.h"
#import <UIImageView+WebCache.h>
#import "CityRequestHandle.h"
#import "DestinationRequestHandle.h"

#import "DesCityRequestHandle.h"
#import "DesCityPriceHandle.h"
#import "URL.h"

#import "ColorWithRandom.h"

#import "AboutCityViewController.h"
#import "GoodLocalRequestHandle.h"

//9376  9891 10437 62 7239 9376
#define kCountryModela @"countryModel.ID == 62"
#define kCountryModelb @"countryModel.ID == 9376"
#define kCountryModelc @"countryModel.ID == 9891"
#define kCountryModeld @"countryModel.ID == 10437"
#define kCountryModele @"countryModel.ID == 7239"
#define kCountryModelf @"countryModel.ID == 9376"


@interface DestinationViewController ()<UITableViewDelegate,UITableViewDataSource,UICollectionViewDataSource,UICollectionViewDelegate,MONActivityIndicatorViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *detailView;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
//tableView的背景
@property (weak, nonatomic) IBOutlet UIView *tableViewBackGround;


//目的地列表对象数组
@property (nonatomic,strong) NSArray *destinationArray;

//传递点击的洲的所在cell的坐标 indexPath.row
@property (nonatomic,assign)NSInteger index;

@end

@implementation DestinationViewController

static NSString *const cellIdentifier = @"destinationCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.backgroundColor = [UIColor lightGrayColor];
    
    
    
    //网络请求
    [self getvalues];
    
    //设置 tableView的代理
    [self initTableView];
    
    //布局collectionView
    [self layoutCollectionView];
    
    //给index默认值
    self.index = 0;
}

//布局collectionView
-(void)layoutCollectionView
{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    
    //设置item的大小
    flowLayout.itemSize = CGSizeMake(120, 160);
    
    //距离上下左右
    flowLayout.sectionInset = UIEdgeInsetsMake(10, 20, 20, 20);
    
    
    self.collectionView.collectionViewLayout = flowLayout;
    //隐藏滚动条
    _collectionView.showsVerticalScrollIndicator = NO;
    //设置代理
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    
    //将collectionView 添加到 self.detailView(UIView)上面
    [self.detailView addSubview:_collectionView];
    
    //注册cell
    [_collectionView registerNib:[UINib nibWithNibName:@"DestinationCell" bundle:nil] forCellWithReuseIdentifier:@"destinationCell"];
    
    //给collectionView一个背景颜色
    _collectionView.backgroundColor = [UIColor whiteColor];
    
    //刷新
    [_collectionView reloadData];
    
}

//网络请求
-(void)getvalues
{
    MONActivityIndicatorView *indicatorView = [[MONActivityIndicatorView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    [self layoutIndicatorView:indicatorView];
    [self.view addSubview:indicatorView];
    [indicatorView startAnimating];
    
    //网络请求
    [[DestinationRequestHandle shareDDestinationRequestHandle]destinationRequestHandle];
    [DestinationRequestHandle shareDDestinationRequestHandle].result = ^(){
        //用数组去接收 返回的数组值
        self.destinationArray = [NSMutableArray arrayWithArray:[DestinationRequestHandle shareDDestinationRequestHandle].destinationArray];
        
        //刷新
        [self.collectionView reloadData];
        [self.tableView reloadData];
        [indicatorView stopAnimating];
        self.tableViewBackGround.backgroundColor = [UIColor colorWithRed:0.536 green:0.466 blue:1.000 alpha:1.000];
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

//设置tableView的代理
-(void)initTableView
{
    //设置代理 UITableViewDelegate  UITableViewDataSource
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.scrollEnabled = NO;
    
}

#pragma mark -- UITableViewDelegate - UITableViewDataSource --
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.destinationArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //使用系统自带 cell,给cell重用标识符
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    //判断cell
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"cell"];
        //样式
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        //字体大小
        cell.textLabel.font = [UIFont systemFontOfSize:15];
        //背景
        cell.selectedBackgroundView = ({
            UIView *view = [UIView new];
            view.backgroundColor = [UIColor lightGrayColor];
            view;
        });
    }
    
    //将对应的值给数据模型
    DestinationCountryModel *model = self.destinationArray[indexPath.row];
    
    //cell显示
    cell.textLabel.text = model.cnname;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    //将点击的对应cell下坐标 赋值给 _index
    self.index = indexPath.row;
    //用点击的时候 请求数据
    DestinationContinentsModel *model = [DestinationContinentsModel new];
    model = self.destinationArray[_index];
    
    //刷新
    //如果不刷新数据, model.array.count 的值不会变, 就会一直出现item的数据个数不对称问题
    [self.collectionView reloadData];
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [UIScreen mainScreen].bounds.size.height - 593;
}


#pragma mark -- CollectionView 代理 --

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    //当第一次运行,还没有手动点击七大洲的时候,给它一个默认数据 0
    DestinationContinentsModel *model = [DestinationContinentsModel new];
    model = self.destinationArray[_index];
    
    if (model.array.count == 0) {
        return 0;
    }else{
        return model.array.count;
    }
    
}

//设置cell
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    DestinationCell *collectionCell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    
    DestinationContinentsModel *model = [DestinationContinentsModel new];
    //洲的数据模型
    //通过点击的index来给数据模型赋值
    model = self.destinationArray[self.index];
    
    DestinationCountryModel *countryModel = [DestinationCountryModel new];
    
    countryModel = model.array[indexPath.item];
    //传递数据模型信息
    collectionCell.model = countryModel;
    return collectionCell;
    
}
//点击item
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
   //从数据模型依次取值
    DestinationContinentsModel *model = [DestinationContinentsModel new];
    model = self.destinationArray[_index];
    DestinationCountryModel *countryModel = [DestinationCountryModel new];
    
    //赋值给国家的数据模型
    countryModel = model.array[indexPath.item];
    
    if (!(countryModel.ID == 62)) {
        
        
        //传递用来拼接的id
        [CityRequestHandle shareCityReqeustHandle].ID = countryModel.ID;
        
        //push到第二界面
        RegionViewController *regionVC = [[RegionViewController alloc]init];
        regionVC.ID = countryModel.ID;
        //传值到 国家城市详情中的网络请求中
        [DesCityRequestHandle shareDesCityRequestHandle].ID = [CityRequestHandle shareCityReqeustHandle].ID;
        //传值 这个国家城市的个数
        [DesCityPriceHandle shareDesCityPriceHandle].ID = countryModel.ID;
        NSLog(@"desCountry:  %ld",[DesCityPriceHandle shareDesCityPriceHandle].ID);
        regionVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"region"];
        [self.navigationController pushViewController:regionVC animated:YES];
    }else{
    
        [GoodLocalRequestHandle shareGoodLocalRequestHandle].ID = countryModel.ID;
        
        AboutCityViewController *about = [[AboutCityViewController alloc]init];
        about = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"aboutVC"];
        [self.navigationController pushViewController:about animated:YES];
    }
    
}



//设置item的大小
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(120, 160);
}






- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
