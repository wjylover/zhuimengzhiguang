//
//  HotContentViewController.m
//  zhuimengzhiguang
//
//  Created by 王建业 on 15/11/11.
//  Copyright © 2015年 王建业. All rights reserved.
//

#import "HotContentViewController.h"
#import "WJYHeadView.h"
#import "HotContentCell.h"
#import "WJYDataManager.h"
#import <MJRefresh.h>
#import "HotContent.h"
#import "Hot.h"

#define kImageHight [UIScreen mainScreen].bounds.size.width / (490 / 285.0)
@interface HotContentViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *hotContentTableView;
@property (nonatomic, strong) NSMutableArray *hotContentArray;
@property (nonatomic, strong) UIVisualEffectView *visualView;
@property (weak, nonatomic) IBOutlet UIView *backView;
@end

@implementation HotContentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 自适应高度
    
    _hotContentTableView.rowHeight = UITableViewAutomaticDimension;
    _hotContentTableView.estimatedRowHeight = 100;
    // 初始化cell
    [_hotContentTableView registerNib:[UINib nibWithNibName:@"HotContentCell" bundle:nil] forCellReuseIdentifier:@"HotContent"];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    _hotContentTableView.estimatedSectionHeaderHeight = 100;
    _hotContentTableView.sectionHeaderHeight = UITableViewAutomaticDimension;

    _hotContentTableView.contentInset = UIEdgeInsetsMake(kImageHight , 0, 0, 0);
    [_hotContentTableView addSubview:_headImageView];
    
    // 设置图片拉伸方式为等比例
    _headImageView.contentMode = UIViewContentModeScaleAspectFill;
    
    //毛玻璃效果
    _visualView = [[UIVisualEffectView alloc]initWithEffect:[UIBlurEffect effectWithStyle:(UIBlurEffectStyleLight)]];
    _visualView.frame = _headImageView.bounds;
    
    _visualView.alpha = 0;
    [_headImageView addSubview:_visualView];
    [self.view insertSubview:_backView aboveSubview:_visualView];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat y = scrollView.contentOffset.y ;
 
    if (y <= - kImageHight) {
        _visualView.alpha = 0;

        CGRect frame = _headImageView.frame;
        frame.origin.y = y;
        frame.size.height = -y;
        _headImageView.frame = frame;
    }else if(y >= -44){
        [_headImageView removeFromSuperview];
        _headImageView.frame = CGRectMake(0, -kImageHight+44, self.view.frame.size.width, kImageHight);
        [self.view addSubview:_headImageView];
        _visualView.alpha = 0.95;
        [self.view insertSubview:_backView aboveSubview:_visualView];
    }else if(y < -44){
        [_headImageView removeFromSuperview];
        _headImageView.frame = CGRectMake(0, -kImageHight, self.view.frame.size.width, kImageHight);
        [_hotContentTableView addSubview:_headImageView];
        _visualView.alpha = (kImageHight + y) / 166 +0.05;
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

- (IBAction)backButton:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
    [self.navigationController setNavigationBarHidden:NO animated:YES];

}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        // 获取xib  view
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"WjyHeadView" owner:self options:nil];
        
        WJYHeadView *header = (WJYHeadView *)[nib objectAtIndex:0];
        header.titelLabel.text = self.hot.title;
        header.timeLabel.text = self.hot.ts_create;
        header.contentLabel.text = self.hot.content;
        return header;
    }else{
        return nil;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 2;
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
