//
//  FZQRecommandTableViewController.m
//  zhuimengzhiguang
//
//  Created by lanou3g on 15/11/9.
//  Copyright © 2015年 王建业. All rights reserved.
//

#import "FZQRecommandTableViewController.h"

@interface FZQRecommandTableViewController ()

@end

@implementation FZQRecommandTableViewController

//定义cell的重用标识
static NSString *const cellIdentify = @"recommandCellID";


- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    //注册cell
    [self.tableView registerNib:[UINib nibWithNibName:@"FZQRecommandTableViewCell" bundle:nil]  forCellReuseIdentifier:cellIdentify];
    
    //设置cell的自定义高度
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 100;
    
    //请求数据
    [self loadData];
    
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


//设置表视图的头视图
//-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//    
//    
//    
//}
@end
