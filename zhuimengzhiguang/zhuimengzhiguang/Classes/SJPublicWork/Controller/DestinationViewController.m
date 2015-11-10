//
//  DestinationViewController.m
//  zhuimengzhiguang
//
//  Created by lanou3g on 15/11/9.
//  Copyright © 2015年 王建业. All rights reserved.
//

#import "DestinationViewController.h"
#import "RequestHandle.h"
#import "DestinationContinentsModel.h"
#import "DestinationCountryModel.h"
#import "URL.h"
@interface DestinationViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *detailView;

//目的地列表对象数组
@property (nonatomic,strong) NSMutableArray *destinationArray;
//国家对象数组
@property (nonatomic,strong) NSMutableArray *countryArray;

@end

@implementation DestinationViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    //当页面将要出现的时候 进行一次刷新
    [self.tableView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置 tableView的代理
    [self initTableView];
    //网络请求
    [self getvalues];
    
}

-(void)getvalues
{
    NSURLSession *urlSession = [NSURLSession sharedSession];
    
    NSURLSessionDataTask *dataTask = [urlSession dataTaskWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:UrlDestination]] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingAllowFragments) error:nil];
        
        NSMutableArray *array = [NSMutableArray array];
        array = [dic valueForKey:@"data"];
        
        self.destinationArray = [NSMutableArray arrayWithCapacity:20];
        
        for (NSDictionary *dict in array) {
            
            //接收五大洲的模型数据
            DestinationContinentsModel *continentsModel = [DestinationContinentsModel new];
            [continentsModel setValuesForKeysWithDictionary:dict];
            [self.destinationArray addObject:continentsModel];
            
            //遍历目的地
            for (NSDictionary *dictionary in dict[@"country"]) {
                
                DestinationCountryModel *model = [DestinationCountryModel new];
                [model setValuesForKeysWithDictionary:dictionary];
                [self.countryArray addObject:model];
                
            }
            //遍历热门目的地
            for (NSDictionary *dictionary in dict[@"hot_country"]) {
                DestinationCountryModel *model = [DestinationCountryModel new];
                [model setValuesForKeysWithDictionary:dictionary];
                [self.countryArray addObject:model];
            }
            [self.tableView reloadData];
        }

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
    
    DestinationContinentsModel *model = self.destinationArray[indexPath.row];
    
    
    cell.textLabel.text = model.cnname;
    
    return cell;
}


//LeftItem
- (IBAction)leftItemAction:(id)sender {
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
