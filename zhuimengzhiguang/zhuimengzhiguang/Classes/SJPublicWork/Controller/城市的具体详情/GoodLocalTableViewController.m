//
//  GoodLocalTableViewController.m
//  zhuimengzhiguang
//
//  Created by lanou3g on 15/11/18.
//  Copyright © 2015年 王建业. All rights reserved.
//

#import "GoodLocalTableViewController.h"
#import "GoodLocalCityModel.h"
#import "GoodLocalRequestHandle.h"
#import "GoodLocalCellTableViewCell.h"
#import "ColorWithRandom.h"

@interface GoodLocalTableViewController ()<MONActivityIndicatorViewDelegate>

@property (nonatomic,strong) NSArray *array;

@end

@implementation GoodLocalTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"GoodLocalCellTableViewCell" bundle:nil] forCellReuseIdentifier:@"goodLocalCell"];
    
    [self getRequestHandle];
    //上拉刷新加载
//    [self layoutMJRefresh];
}


//-(void)layoutMJRefresh
//{
//    ColorWithRandom *refresh = [[ColorWithRandom alloc]init];
//    MJRefreshAutoGifFooter *footer = [MJRefreshAutoGifFooter footerWithRefreshingTarget:self refreshingAction:@selector(refreshAction:)];
//    [refresh reFreshWithMJRefresh:footer];
//    self.tableView.mj_footer = footer;
//}
////mjrefresh  刷新事件
//-(void)refreshAction:(MJRefreshAutoGifFooter *)footer
//{
//    //请求数据
//    [[GoodLocalRequestHandle shareGoodLocalRequestHandle]requestGoodLocalRequestHandle];
//    //block回调
//    [GoodLocalRequestHandle shareGoodLocalRequestHandle].result = ^(){
//        
//        self.array = [NSArray arrayWithArray:[GoodLocalRequestHandle shareGoodLocalRequestHandle].dataArray];
//        
//        [self.tableView reloadData];
//        //结束刷新状态
//        [footer endRefreshing];
//    };
//}



//网络请求
-(void)getRequestHandle
{
    //加载动画
    MONActivityIndicatorView *indicatorView = [[MONActivityIndicatorView alloc]init];
    [self layoutIndicatorView:indicatorView];
    [self.view addSubview:indicatorView];
    [indicatorView startAnimating];

    [[GoodLocalRequestHandle shareGoodLocalRequestHandle]requestGoodLocalRequestHandle];
    [GoodLocalRequestHandle shareGoodLocalRequestHandle].result = ^(){
        
        self.array = [NSArray arrayWithArray:[GoodLocalRequestHandle shareGoodLocalRequestHandle].dataArray];
        
        [self.tableView reloadData];
        [indicatorView stopAnimating];
    };
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (self.array.count == 0) {
        return 1;
    }else{
        return self.array.count;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    GoodLocalCellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"goodLocalCell" forIndexPath:indexPath];
    
    if (self.array.count == 0) {
        return cell;
    }else{
        GoodLocalCityModel *model = [[GoodLocalCityModel alloc]init];
        model = self.array[indexPath.row];
        
        cell.model = model;
        
        return cell;
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 350;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
