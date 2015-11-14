//
//  WJYScenerySpotViewController.m
//  zhuimengzhiguang
//
//  Created by 王建业 on 15/11/13.
//  Copyright © 2015年 王建业. All rights reserved.
//

#import "WJYScenerySpotViewController.h"
#import "ScenerySpotContent.h"
#import "WJYDataManager.h"
#import "ScenicSpotCell.h"

#define kImageHight [UIScreen mainScreen].bounds.size.width / (490 / 285.0)

@interface WJYScenerySpotViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *scenerySpotTableView;
@property (nonatomic, strong) UIVisualEffectView *visualView;
@property (weak, nonatomic) IBOutlet UIView *backView;
@end

@implementation WJYScenerySpotViewController
- (IBAction)backButtonAction:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [WJYDataManager sharedManager].scenerySpotContentBlock = ^(){
        self.scenery = [WJYDataManager sharedManager].scenerySpotContent;
        [_headImageView sd_setImageWithURL:[NSURL URLWithString:_scenery.cover] placeholderImage:nil];
        [self.scenerySpotTableView reloadData];
    };
    // 自适应高度
    
    _scenerySpotTableView.rowHeight = UITableViewAutomaticDimension;
    _scenerySpotTableView.estimatedRowHeight = 100;
    // 初始化cell
    [_scenerySpotTableView registerNib:[UINib nibWithNibName:@"ScenicSpotCell" bundle:nil] forCellReuseIdentifier:@"ScenicSpotCellContent"];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    _scenerySpotTableView.estimatedSectionHeaderHeight = 100;
    _scenerySpotTableView.sectionHeaderHeight = UITableViewAutomaticDimension;
    
    _scenerySpotTableView.contentInset = UIEdgeInsetsMake(kImageHight , 0, 0, 0);
    [_scenerySpotTableView addSubview:_headImageView];
    
    // 设置图片拉伸方式为等比例
    _headImageView.contentMode = UIViewContentModeScaleAspectFill;
    
    //毛玻璃效果
    _visualView = [[UIVisualEffectView alloc]initWithEffect:[UIBlurEffect effectWithStyle:(UIBlurEffectStyleLight)]];
    _visualView.frame = _headImageView.bounds;
    
    _visualView.alpha = 0;
    [_headImageView addSubview:_visualView];
    [self.view insertSubview:_backView aboveSubview:_visualView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat y = scrollView.contentOffset.y ;
    NSLog(@"%f",y);
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
        [_scenerySpotTableView addSubview:_headImageView];
        _visualView.alpha = (kImageHight + y) / 166 +0.05;
    }
}
- (void)viewWillAppear:(BOOL)animated
{

    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ScenicSpotCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ScenicSpotCellContent" forIndexPath:indexPath];
    return cell;
}


@end
