//
//  HotContentViewController.m
//  zhuimengzhiguang
//
//  Created by 王建业 on 15/11/11.
//  Copyright © 2015年 王建业. All rights reserved.
//

#import "HotContentViewController.h"
#import "HotContentCell.h"
#import "WJYDataManager.h"
#import <MJRefresh.h>
#import "HotContent.h"
#import "Hot.h"

@interface HotContentViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *hotContentTableView;
@property (nonatomic, strong) NSMutableArray *hotContentArray;
@property (nonatomic, strong) UIImageView *headImageView;
@end

@implementation HotContentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 自适应高度
    _hotContentTableView.rowHeight = UITableViewAutomaticDimension;
    _hotContentTableView.estimatedRowHeight = 100;
    // 初始化cell
    [_hotContentTableView registerNib:[UINib nibWithNibName:@"HotContentCell" bundle:nil] forCellReuseIdentifier:@"HotContent"];
    
    
    _hotContentTableView.contentInset = UIEdgeInsetsMake(136, 0, 0, 0);
    
    _headImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"1.jpg"]];
    _headImageView.frame = CGRectMake(0, -200, self.view.frame.size.width, 200);
    _headImageView.contentMode = UIViewContentModeScaleAspectFill;
    [_hotContentTableView addSubview:_headImageView];

}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat y = scrollView.contentOffset.y ;
    NSLog(@"%f",y);
    if (y < - 136) {
        CGRect frame = _headImageView.frame;
        frame.origin.y = y;
        frame.size.height = -y;
        _headImageView.frame = frame;
    }
}
- (void)viewWillAppear:(BOOL)animated
{
    self.hotContentArray = [NSMutableArray arrayWithCapacity:20];
    [[WJYDataManager sharedManager] getHotContentDataArrayWithHotID:self.hot.hotID];
    [WJYDataManager sharedManager].hotContentBlock = ^(){
        self.hotContentArray = [WJYDataManager sharedManager].hotContentDataArray;
        [self.hotContentTableView reloadData];
    };
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 20;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _hotContentArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HotContentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HotContent" forIndexPath:indexPath];
    HotContent *hotContent = self.hotContentArray[indexPath.section];
    cell.titelLabel.text = [NSString stringWithFormat:@"%ld.%@",indexPath.section + 1,hotContent.sc_name];
    [cell.contentImage sd_setImageWithURL:[NSURL URLWithString:hotContent.cover_picture] placeholderImage:nil];
    cell.contentLabel.text = hotContent.content;
    if ([hotContent.tips isEqualToString:@""]) {
        cell.tipsLabel.text = @"门票: 无";
    }else{
        cell.tipsLabel.text = [NSString stringWithFormat:@"门票: %@",hotContent.tips];
    }
    if([hotContent.line isEqualToString:@""]){
        cell.lineLabel.text = @"路线: 无";
    }else{
        cell.lineLabel.text = [NSString stringWithFormat:@"路线: %@",hotContent.line];
    }
    return cell;
}
@end
