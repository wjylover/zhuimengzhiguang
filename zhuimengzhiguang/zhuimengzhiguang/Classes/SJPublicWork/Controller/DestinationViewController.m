//
//  DestinationViewController.m
//  zhuimengzhiguang
//
//  Created by lanou3g on 15/11/9.
//  Copyright © 2015年 王建业. All rights reserved.
//

#import "DestinationViewController.h"
#import "DestinationContinentsModel.h"
#import "DestinationCountryModel.h"
#import "DestinationCell.h"
#import "URL.h"
@interface DestinationViewController ()<UITableViewDelegate,UITableViewDataSource,UICollectionViewDataSource,UICollectionViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *detailView;

//目的地列表对象数组
@property (nonatomic,strong) NSMutableArray *destinationArray;
//国家对象数组
@property (nonatomic,strong) NSMutableArray *countryArray;

@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation DestinationViewController

static NSString *const cellIdentifier = @"destinationCell";

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    //当页面将要出现的时候 进行一次刷新
    [self.tableView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.backgroundColor = [UIColor lightGrayColor];
    
    //设置 tableView的代理
    [self initTableView];
    //网络请求
    [self getvalues];
    //布局collectionView
    [self layoutCollectionView];
    
}

//布局collectionView
-(void)layoutCollectionView
{
    
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    
    //设置item的大小
    flowLayout.itemSize = CGSizeMake(110, 150);
    
    //距离上下左右
    flowLayout.sectionInset = UIEdgeInsetsMake(20, 30, 10, 10);
    
    self.collectionView = [[UICollectionView alloc]initWithFrame:self.detailView.bounds collectionViewLayout:flowLayout];
    
    //设置代理
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    
    //将collectionView 添加到 self.detailView(UIView)上面
    [self.detailView addSubview:_collectionView];
    
    //注册cell
    [_collectionView registerNib:[UINib nibWithNibName:@"DestinationCell" bundle:nil] forCellWithReuseIdentifier:@"destinationCell"];
    
    //给collectionView一个背景颜色
    _collectionView.backgroundColor = [UIColor lightGrayColor];
    
}

//网络请求
-(void)getvalues
{
    [self.destinationArray removeAllObjects];
    [self.countryArray removeAllObjects];
    
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
            
//            //遍历目的地
//            for (NSDictionary *dictionary in dict[@"country"]) {
//                
//                DestinationCountryModel *model = [DestinationCountryModel new];
//                [model setValuesForKeysWithDictionary:dictionary];
//                [self.countryArray addObject:model];
//                
//            }
//            //遍历热门目的地
//            for (NSDictionary *dictionary in dict[@"hot_country"]) {
//                DestinationCountryModel *model = [DestinationCountryModel new];
//                [model setValuesForKeysWithDictionary:dictionary];
//                [self.countryArray addObject:model];
//            }
//            NSLog(@"%@",self.countryArray);
        }
        [self.tableView reloadData];
        [self.collectionView reloadData];
    }];
    
    [dataTask resume];
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
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        cell.textLabel.font = [UIFont systemFontOfSize:15];
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
//    DestinationContinentsModel *model = self.destinationArray[indexPath.row];
//    self.countryArray = [NSMutableArray arrayWithArray:model.country];
}


#pragma mark -- CollectionView 代理 --
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    DestinationContinentsModel *model = [DestinationContinentsModel new];
    model = self.destinationArray[section];
    
    return [model.country.count + model.hot_country.count];
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    DestinationCell *collectionCell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    NSLog(@"%@",self.countryArray[indexPath.item]);
    DestinationCountryModel *model = self.countryArray[indexPath.item];
    
    collectionCell.cnnameLabel.text = model.cnname;
    collectionCell.ennameLabel.text = model.enname;
    
    return collectionCell;
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
