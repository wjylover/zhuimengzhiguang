//
//  WJYCollectViewController.m
//  zhuimengzhiguang
//
//  Created by 王建业 on 15/11/17.
//  Copyright © 2015年 王建业. All rights reserved.
//

#import "WJYCollectViewController.h"
#import "Collect.h"
#import "WJYCollectCell.h"
#import <MJRefresh.h>
#import "WJYCoreDataManager.h"
#import "WJYDataManager.h"
#import "ScenerySpotContent.h"
#import "WJYScenerySpotViewController.h"
#define kImageHight [UIScreen mainScreen].bounds.size.width / (490 / 285.0)

@interface WJYCollectViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *collectTableView;
@property (nonatomic, strong) NSMutableArray *collectArray;
@property (nonatomic, strong) NSMutableArray *collectContentArray;
@property (nonatomic, strong) ScenerySpotContent *collrctContent;
@end

@implementation WJYCollectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.collectArray = [NSMutableArray arrayWithCapacity:20];
    self.collectContentArray = [NSMutableArray arrayWithCapacity:20];
    self.collrctContent = [ScenerySpotContent new];
    [self.collectArray addObjectsFromArray:[[WJYCoreDataManager sharedManager] getAllCollect]];
    for (Collect *collect in _collectArray) {
        [[WJYDataManager sharedManager] getScenicSpotContentArrayWithTypeID:collect.typeID];
    }
    [WJYDataManager sharedManager].scenerySpotContentBlock = ^(){
        self.collrctContent = [WJYDataManager sharedManager].scenerySpotContent;
        [self.collectContentArray addObject:self.collrctContent];
        [self.collectTableView reloadData];
        
    };
    [self.collectTableView registerNib:[UINib nibWithNibName:@"WJYCollectCell" bundle:nil] forCellReuseIdentifier:@"CollectCell"];
     self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0.313 green:0.782 blue:1.000 alpha:1.000];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back_arrow"] style:UIBarButtonItemStyleDone target:self action:@selector(backAction:)];
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor whiteColor];
}

- (void)backAction:(UIBarButtonItem *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 150;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.hidesBottomBarWhenPushed = YES;
    WJYScenerySpotViewController *scenerySpotVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"ScenetySpot"];
    scenerySpotVC.scenery = _collectContentArray[indexPath.row];
    [scenerySpotVC.headImageView sd_setImageWithURL:[NSURL URLWithString:[_collectContentArray[indexPath.row] cover]]];
    scenerySpotVC.headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, -kImageHight, self.view.frame.size.width, kImageHight)];
    [self.navigationController pushViewController:scenerySpotVC animated:YES];
    self.hidesBottomBarWhenPushed = NO;}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _collectContentArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WJYCollectCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CollectCell" forIndexPath:indexPath];
    ScenerySpotContent *scenery = _collectContentArray[indexPath.row];
    [cell.collectImage sd_setImageWithURL:[NSURL URLWithString:scenery.cover]];
    
    cell.titelLabel.text = scenery.title;
    return cell;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
