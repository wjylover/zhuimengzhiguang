//
//  FZQRecommandTableViewController.m
//  zhuimengzhiguang
//
//  Created by lanou3g on 15/11/9.
//  Copyright © 2015年 王建业. All rights reserved.
//

#import "FZQRecommandTableViewController.h"

@interface FZQRecommandTableViewController ()

//声明一个刷新控制器



@end

@implementation FZQRecommandTableViewController

//定义cell的重用标识
static NSString *const cellIdentify = @"recommandCellID";

//重写init方法,将tableView的样式设为group的样式,区头就会跟着滑动了
-(instancetype)initWithStyle:(UITableViewStyle)style{
    if (self = [super initWithStyle:UITableViewStyleGrouped]) {
        return self;
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
     
    
    //注册cell
    [self.tableView registerNib:[UINib nibWithNibName:@"FZQRecommandTableViewCell" bundle:nil]  forCellReuseIdentifier:cellIdentify];
    
    //设置cell的自定义高度
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 100;
    
    //加载数据
    [self loadData];
    
    //创建一个尾视图刷新数据
    //每次上拉一次就执行gaiblock方法
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
       
        //加载数据
        [self loadData];
        
        //停止刷新
        [self.tableView.mj_footer endRefreshing];
    }];
    
  
   }


//请求数据
-(void)loadData{
    //请求数据
    [[RecommandDataManager sharedRecommandDataManager] analysisDataFromUrl:kRecommandURL];
    
    //刷新表数据
    [RecommandDataManager sharedRecommandDataManager].flash = ^(){
        [self.tableView reloadData];
    };

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

    return [RecommandDataManager sharedRecommandDataManager].users.count;
}


//设置cell的内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    FZQRecommandTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentify forIndexPath:indexPath];
    
    //设置cell的内容
    cell.user = [RecommandDataManager sharedRecommandDataManager].users[indexPath.row];
    cell.milage = [RecommandDataManager sharedRecommandDataManager].miles[indexPath.row];
    
    return cell;
}




//设置表示图的头视图大小
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}

//设置表视图的头视图

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kUIScreenWidth, 30)];
    
    //创建图片视图
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 5, 8, 25)];
    imgView.image = [UIImage imageNamed:@"companion_bg_blue.png"];
    imgView.layer.cornerRadius = 4;
    imgView.layer.masksToBounds = YES;
    [view addSubview:imgView];
  
    //创建文本框视图
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(imgView.frame.origin.x+15, imgView.frame.origin.y, kUIScreenWidth-35, 30)];
    label.text = @"行走在路上";
    label.font = [UIFont fontWithName:@"Telugu Sangam MN" size:20.0];
    [view addSubview:label];
    view.backgroundColor = [UIColor clearColor];
    
    
    return view;
}


//点击指定的cell
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    
    //创建一个详情界面控制器
    ShowInformationCollectionViewController *showInformationCVC = [[ShowInformationCollectionViewController alloc] initWithCollectionViewLayout:flowLayout];
    
    //创建控制器的跳转形式
    showInformationCVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    
    //传值
    showInformationCVC.mileage = [RecommandDataManager sharedRecommandDataManager].miles[indexPath.row];
    
    //跳转
    [self showDetailViewController:showInformationCVC sender:nil];
    
}

@end
