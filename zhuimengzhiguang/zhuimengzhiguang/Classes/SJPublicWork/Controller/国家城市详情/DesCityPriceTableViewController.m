//
//  DesCityPriceTableViewController.m
//  zhuimengzhiguang
//
//  Created by lanou3g on 15/11/13.
//  Copyright © 2015年 王建业. All rights reserved.
//

#import "DesCityPriceTableViewController.h"
#import "DesCityPriceHandle.h"
#import "DesCityPriceModel.h"
#import "DesCityPriceCell.h"

@interface DesCityPriceTableViewController ()

@property (nonatomic,strong) NSArray *array;

@end

@implementation DesCityPriceTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
   //网络请求
    [self getValuesReuqestHandle];
    //上拉刷新
    [self mjRefreshWithReLoad];
}
-(void)mjRefreshWithReLoad
{
    MJRefreshBackGifFooter *footer = [MJRefreshBackGifFooter footerWithRefreshingTarget:self refreshingAction:@selector(refreshAction:)];
    /** 普通闲置状态 */
    [footer setImages:nil forState:MJRefreshStateIdle];
    /** 松开就可以进行刷新的状态 */
    [footer setImages:nil forState:MJRefreshStatePulling];
    /** 正在刷新中的状态 */
    [footer setImages:nil forState:MJRefreshStateRefreshing];
    
    //设置尾部的显示
    self.tableView.mj_footer = footer;
}

//刷新数据的方法
-(void)refreshAction:(MJRefreshFooter*)foot
{
    //重新请求数据
    [[DesCityPriceHandle shareDesCityPriceHandle]requestDesCityPriceHandle];
    //回调block
    [DesCityPriceHandle shareDesCityPriceHandle].result = ^(){
        //数据赋值
        self.array = [DesCityPriceHandle shareDesCityPriceHandle].dataArray;
        //刷新
        [self.tableView reloadData];
    };
    //结束刷新
    [foot endRefreshing];
}


//网络请求
-(void)getValuesReuqestHandle
{
    [[DesCityPriceHandle shareDesCityPriceHandle]requestDesCityPriceHandle];
    [DesCityPriceHandle shareDesCityPriceHandle].result = ^(){
        self.array =  [NSArray arrayWithArray:[DesCityPriceHandle shareDesCityPriceHandle].dataArray];
        [self.tableView reloadData];
    };
    
    //注册
    [self.tableView registerNib:[UINib nibWithNibName:@"DesCityPriceCell" bundle:nil] forCellReuseIdentifier:@"desCityPriceCell"];
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

    return self.array.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DesCityPriceCell *cell = [tableView dequeueReusableCellWithIdentifier:@"desCityPriceCell" forIndexPath:indexPath];
    
    DesCityPriceModel *model = [[DesCityPriceModel alloc]init];
    model = self.array[indexPath.item];
    
    cell.model = model;
    
    return cell;
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
