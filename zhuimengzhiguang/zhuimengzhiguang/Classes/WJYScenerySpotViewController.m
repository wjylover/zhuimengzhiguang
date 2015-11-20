//
//  WJYScenerySpotViewController.m
//  zhuimengzhiguang
//
//  Created by 王建业 on 15/11/13.
//  Copyright © 2015年 王建业. All rights reserved.
//

#import "WJYScenerySpotViewController.h"
#import "WJYCoreDataManager.h"
#import "Collect.h"
#import <MapKit/MapKit.h>
#import "KCAnnotation.h"
#import <CoreLocation/CoreLocation.h>
#import "ScenerySpotContent.h"
#import "WJYMapHeadView.h"
#import "WJYDataManager.h"
#import "ScenicSpotCell.h"

#define kImageHight [UIScreen mainScreen].bounds.size.width / (490 / 285.0)

@interface WJYScenerySpotViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *scenerySpotTableView;
@property (nonatomic, strong) UIVisualEffectView *visualView;
@property (weak, nonatomic) IBOutlet UIView *backView;
@property (nonatomic, strong) KCAnnotation *annotation;
@property (nonatomic, strong) MKMapView *mapView;
@end

@implementation WJYScenerySpotViewController
- (IBAction)backButtonAction:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [self.mapView removeAnnotations:self.mapView.annotations];
    [self.mapView removeFromSuperview];
    self.mapView.delegate = nil;
    self.mapView = nil;
   
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
    [_headImageView sd_setImageWithURL:[NSURL URLWithString:_scenery.cover] placeholderImage:nil];
    [self.scenerySpotTableView reloadData];
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
    if (y <= - kImageHight) {
        _visualView.alpha = 0;
        
        CGRect frame = _headImageView.frame;
        frame.origin.y = y;
        frame.size.height = -y;
        _headImageView.frame = frame;
    }else if(y >= -54){
        [_headImageView removeFromSuperview];
        _headImageView.frame = CGRectMake(0, -kImageHight+54, self.view.frame.size.width, kImageHight);
        [self.view addSubview:_headImageView];
        _visualView.alpha = 0.95;
        [self.view insertSubview:_backView aboveSubview:_visualView];
    }else if(y < -54){
        [_headImageView removeFromSuperview];
        _headImageView.frame = CGRectMake(0, -kImageHight, self.view.frame.size.width, kImageHight);
        [_scenerySpotTableView addSubview:_headImageView];
        _visualView.alpha = (kImageHight + y) / 156 +0.05;
    }
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"WJYMapHeadView" owner:self options:nil];
    
    WJYMapHeadView *header = (WJYMapHeadView *)[nib objectAtIndex:0];
    _mapView=[[MKMapView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 150)];
    [header.mapBackView addSubview:_mapView];
    _mapView.mapType = MKMapTypeStandard;
    CGFloat longitude = [self.scenery.longitude floatValue];
    CGFloat latitude = [self.scenery.lat floatValue];
    CLLocationCoordinate2D location=CLLocationCoordinate2DMake(latitude, longitude);
    _annotation=[[KCAnnotation alloc]init];
    _annotation.title = self.scenery.address;
    _annotation.coordinate=location;
    [_mapView addAnnotation:_annotation];
    //创建一个以center为中心，上下各1000米，左右各1000米得区域，但其是一个矩形，不符合MapView的横纵比例
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(location,3000, 3000);
    //以上代码创建出来一个符合MapView横纵比例的区域
    MKCoordinateRegion adjustedRegion = [_mapView regionThatFits:viewRegion];
    [_mapView setRegion:adjustedRegion animated:YES];

    
    UIButton *mapButton = [UIButton buttonWithType:UIButtonTypeSystem];
    mapButton.frame = CGRectMake(0, 0, self.view.frame.size.width, 150);
    [_mapView addSubview:mapButton];
    
    header.scoreLabel.text = [NSString stringWithFormat:@"评分: %.1f",self.scenery.allstar / 10.0];
    header.enjoyLabel.text = [NSString stringWithFormat:@"%ld人喜欢",self.scenery.grade_people];
    header.addressLabel.text = self.scenery.address;
    return header;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 240;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ScenicSpotCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ScenicSpotCellContent" forIndexPath:indexPath];
    cell.addressLabel.text = [NSString stringWithFormat:@"地址: %@",self.scenery.address];

    cell.pice.text = [NSString stringWithFormat:@"门票: %@",self.scenery.ticket];
    cell.phoneTabel.text = [NSString stringWithFormat:@"电话: %@",self.scenery.phone];
    cell.desLabel.text = [NSString stringWithFormat:@"简介: %@",self.scenery.content];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (IBAction)controllerButtonAction:(UIButton *)sender {
    Collect *collect = [[WJYCoreDataManager sharedManager] getCollectWithTypeID:self.typeID];
    if ([collect.typeID isEqualToString:self.typeID]) {
        
    }else{
        [[WJYCoreDataManager sharedManager] addCollect:self.typeID];
    }
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"收藏成功" message:nil preferredStyle:UIAlertControllerStyleAlert];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
    }]];
    
    [self presentViewController:alert animated:YES completion:^{
        
    }];

}


@end
