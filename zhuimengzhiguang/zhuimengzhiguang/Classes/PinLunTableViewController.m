//
//  PinLunTableViewController.m
//  zhuimengzhiguang
//
//  Created by lanou3g on 15/11/12.
//  Copyright © 2015年 王建业. All rights reserved.
//

#import "PinLunTableViewController.h"

@interface PinLunTableViewController ()

//存储所有回复对象
@property(nonatomic,strong)NSMutableArray *allDatas;

@end

@implementation PinLunTableViewController

static NSString *const cellIdentify = @"pinLunCellID";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"日志详情";

    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(returnAction:)] ;
    

  
    //自定义cell的高度
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 100;

    
    //注册cell
    [self.tableView registerNib:[UINib nibWithNibName:@"pinLunTableViewCell" bundle:nil]    forCellReuseIdentifier:cellIdentify];
    
    
}


-(void)viewWillAppear:(BOOL)animated{
    
    //加载数据
    [self loadData];
    
}


-(void)loadData{
    NSLog(@"%ld",self.logList.logId);
    
    
    //根据得到的日志id解析数据
    NSString *urlString = [NSString stringWithFormat:@"%@%ld",kDetailRecommandURL,self.logList.logId ];
    
    NSString *UrlString = [urlString stringByAppendingString:kDetailRecommandURL1];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:UrlString]];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
                               //解析数据
                               NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
                               NSArray *array = dict[@"commentslist"];
                               for (NSDictionary *dic in array) {
                                   pinLun *pinlun = [pinLun new];
                                   [pinlun setValuesForKeysWithDictionary:dic];
                                   [self.allDatas addObject:pinlun];
                               }
                               
                               for (pinLun *pinlun in self.allDatas) {
                                   NSLog(@"%@",pinlun);
                               }
                               
                               [self.tableView reloadData];
                           }];
}

//返回上个页面
-(void)returnAction:(UIBarButtonItem *)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.allDatas.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    pinLunTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentify forIndexPath:indexPath];
    
    cell.pinlun = self.allDatas[indexPath.row];
   
    //给cell设置毛玻璃效果
    //创建毛玻璃对象
    UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    //创建毛玻璃视图对象
    UIVisualEffectView *visualEV = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    visualEV.alpha = 0.8;
    visualEV.frame = cell.bounds;
    visualEV.alpha = 0.1;
    //将毛玻璃视图对象加入cell上
    [cell.contentView addSubview:visualEV];
    
    
    return cell;
}

-(NSMutableArray *)allDatas{
    if(!_allDatas){
        _allDatas = [NSMutableArray array];
    }
    return _allDatas;
}



@end
