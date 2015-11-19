//
//  FreeTableViewController.m
//  zhuimengzhiguang
//
//  Created by lanou3g on 15/11/18.
//  Copyright © 2015年 王建业. All rights reserved.
//

#import "FreeTableViewController.h"
//超值自由行
#import "MoreDesCityModel.h"
#import "MoreDesCityCell.h"
#import "MoreDesCityRequestHandle.h"

#import "ColorWithRandom.h"

@interface FreeTableViewController ()

@property (nonatomic,strong) NSArray *array;

@end

@implementation FreeTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //注册cell
    [self.tableView registerNib:[UINib nibWithNibName:@"MoreDesCityCell" bundle:nil] forCellReuseIdentifier:@"moreDesCityCell"];
    //网络请求
    [self getValuesRequest];
    //上拉刷新
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
//    [[MoreDesCityRequestHandle shareMoreDesCityRequestHandle]requestHandleWithMoreDesCityRequestHandle];
//    //block回调
//    [MoreDesCityRequestHandle shareMoreDesCityRequestHandle].result = ^(){
//        
//        self.array = [NSArray arrayWithArray:[MoreDesCityRequestHandle shareMoreDesCityRequestHandle].dataArray];
//        
//        [self.tableView reloadData];
//        //结束刷新状态
//        [footer endRefreshing];
//    };
//}


//网络请求
-(void)getValuesRequest
{
    //请求数据
    [[MoreDesCityRequestHandle shareMoreDesCityRequestHandle]requestHandleWithMoreDesCityRequestHandle];
    //block回调
    [MoreDesCityRequestHandle shareMoreDesCityRequestHandle].result = ^(){
        
        self.array = [NSArray arrayWithArray:[MoreDesCityRequestHandle shareMoreDesCityRequestHandle].dataArray];
        
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

    if (self.array.count == 0) {
        return 1;
    }else{
        return self.array.count;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MoreDesCityCell *cell = [tableView dequeueReusableCellWithIdentifier:@"moreDesCityCell" forIndexPath:indexPath];
    
    //判断数组里面是否有值
    if (self.array.count == 0) {
        return cell;
    }else{
        
        //用数据模型接收数据 并复制给cell
        MoreDesCityModel *more = [[MoreDesCityModel alloc]init];
        more = self.array[indexPath.row];
        
        cell.model = more;
        
        return cell;
        
    }

    
    return cell;
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
