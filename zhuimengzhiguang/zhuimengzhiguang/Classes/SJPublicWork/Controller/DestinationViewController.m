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
@interface DestinationViewController ()<UITableViewDelegate,UITableViewDataSource,UICollectionViewDataSource,UICollectionViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *detailView;

//目的地列表对象数组
@property (nonatomic,strong) NSArray *destinationArray;
//collectionView
@property (nonatomic, strong) UICollectionView *collectionView;
//传递点击的洲的所在cell的坐标 indexPath.row
@property (nonatomic,assign)NSInteger index;

//弃用
//国家对象数组
//@property (nonatomic,strong) NSMutableArray *countryArray;
//@property (nonatomic,assign)NSInteger countIndex;

@end

@implementation DestinationViewController

static NSString *const cellIdentifier = @"destinationCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.backgroundColor = [UIColor lightGrayColor];
    
    //设置 tableView的代理
    [self initTableView];
    //网络请求
    [self getvalues];
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
    
    self.collectionView = [[UICollectionView alloc]initWithFrame:self.detailView.bounds collectionViewLayout:flowLayout];
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
    /*
    [self.destinationArray removeAllObjects];
    
    NSURLSession *urlSession = [NSURLSession sharedSession];
    
    NSURLSessionDataTask *dataTask = [urlSession dataTaskWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:UrlDestination]] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingAllowFragments) error:nil];
        
        NSMutableArray *array = [NSMutableArray array];
        array = [dic valueForKey:@"data"];
        
        self.destinationArray = [NSMutableArray arrayWithCapacity:20];
        self.countryArray = [NSMutableArray arrayWithCapacity:20];
        
        for (NSDictionary *dict in array) {
            
            //接收五大洲的模型数据
            DestinationContinentsModel *continentsModel = [DestinationContinentsModel new];
            [continentsModel setValuesForKeysWithDictionary:dict];
            [self.destinationArray addObject:continentsModel];
        }
        
        [self.tableView reloadData];
        [self.collectionView reloadData];
    }];
    
    [dataTask resume];
     */
    //网络请求
    [[DestinationRequestHandle shareDDestinationRequestHandle]destinationRequestHandle];
    [DestinationRequestHandle shareDDestinationRequestHandle].result = ^(){
        //用数组去接收 返回的数组值
        self.destinationArray = [NSMutableArray arrayWithArray:[DestinationRequestHandle shareDDestinationRequestHandle].destinationArray];
        
        //刷新
        [self.collectionView reloadData];
        [self.tableView reloadData];
    };
}

//设置tableView的代理
-(void)initTableView
{
    //设置代理 UITableViewDelegate  UITableViewDataSource
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
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
    
    return model.array.count;
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
    /*
    //如果itme的个数和count的个数相等或者小于count 就显示 热门 中的国家
    if (model.hot_countries.count - 1 >= indexPath.item) {
        
        countryModel = model.hot_countries[indexPath.item];
        
        //赋值cell
        collectionCell.cnnameLabel.text = countryModel.cnname;
        collectionCell.ennameLabel.text = countryModel.enname;
        [collectionCell.picView sd_setImageWithURL:[NSURL URLWithString:countryModel.photo] placeholderImage:[UIImage imageNamed:@"12"] completed:nil];
        
        return collectionCell;
        
        
    }else{
        //否则 显示普通的国家(从 hot_countries.count 往后展示)
        countryModel = model.countries[indexPath.item - model.hot_countries.count];
        
        //赋值cell
        collectionCell.cnnameLabel.text = countryModel.cnname;
        collectionCell.ennameLabel.text = countryModel.enname;
        [collectionCell.picView sd_setImageWithURL:[NSURL URLWithString:countryModel.photo] placeholderImage:[UIImage imageNamed:@"12"] completed:nil];
        
        return collectionCell;
    }
     */
    
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
    //传递用来拼接的id
    [CityRequestHandle shareCityReqeustHandle].ID = countryModel.ID;
    
    /*
    NSLog(@"=========%ld===========",indexPath.item);
    //判断点击的item
    if (model.hot_countries.count - 1 >= indexPath.item) {
        countryModel = model.hot_countries[indexPath.item];
        [CityRequestHandle shareCityReqeustHandle].ID = countryModel.ID;
    }else{
        countryModel = model.countries[indexPath.item];
        [CityRequestHandle shareCityReqeustHandle].ID = countryModel.ID;
    }
     */
    
    //push到第二界面
     RegionViewController *regionVC = [[RegionViewController alloc]init];
    regionVC.ID = countryModel.ID;
    //传值到 国家城市详情中的网络请求中
    [DesCityRequestHandle shareDesCityRequestHandle].ID = [CityRequestHandle shareCityReqeustHandle].ID;
    [DesCityPriceHandle shareDesCityPriceHandle].ID = [CityRequestHandle shareCityReqeustHandle].ID;
    //传值 这个国家城市的个数
    [DesCityPriceHandle shareDesCityPriceHandle].count = countryModel.count;
    
    regionVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"region"];
    [self.navigationController pushViewController:regionVC animated:YES];
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
