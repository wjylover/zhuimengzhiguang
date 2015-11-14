//
//  ShowInformationCollectionViewController.m
//  zhuimengzhiguang
//
//  Created by lanou3g on 15/11/10.
//  Copyright © 2015年 王建业. All rights reserved.
//

#import "ShowInformationCollectionViewController.h"

@interface ShowInformationCollectionViewController ()<UICollectionViewDelegateFlowLayout>

//变焦图片作为底层
@property(nonatomic,strong)UIImageView *spaceImgView;
//返回按钮
@property(nonatomic,strong)UIButton *returnBtn;
//目的地
@property(nonatomic,strong)UILabel *addressLabel;
//日期
@property(nonatomic,strong)UILabel *dataLabel;
//距离
@property(nonatomic,strong)UILabel *distanceLabel;

@end

@implementation ShowInformationCollectionViewController

//设置item的重用标识
static NSString * const reuseIdentifier = @"cellID";
//设置区头重用视图的标识
static NSString *const reuseHeaderIdentifier = @"HeaderID";
//设置区尾重用视图的标识
static NSString *const reuseFooterIdentifier = @"FooterID";


- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    //注册item
    [self.collectionView registerNib:[UINib nibWithNibName:@"ShowInforCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:reuseIdentifier];
    
    //注册区头视图
    [self.collectionView registerNib:[UINib nibWithNibName:@"CollectionHeaderReusableView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader  withReuseIdentifier:reuseHeaderIdentifier];
    
    //注册区尾视图
    [self.collectionView registerNib:[UINib nibWithNibName:@"CollectionFooterReusableView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter  withReuseIdentifier:reuseFooterIdentifier];
    
    //添加视图
    [self loadViews];
    
    
    //设置contentInset属性(上左下右的值),重点
    self.collectionView.contentInset = UIEdgeInsetsMake(imageHeight, 0, 0, 0);
    
    //自定义cell的高度
  

    //调用block
    [ShowInformationDataManager sharedShowInformationDataManager].getValue = ^(User *user,Mileage *mileage){
    
        
        
        
            //获得图片网址
            NSString *urlString = user.spaceImage;
        
        
        
        
            //设置变焦图片的大小和位置
            [_spaceImgView sd_setImageWithURL:[NSURL URLWithString:urlString] placeholderImage:[UIImage imageNamed:@"placeImage5.jpg"]];
        
        //设置图片视图的内容尺寸
        _spaceImgView.contentMode = UIViewContentModeScaleToFill;
        
        _spaceImgView.frame = CGRectMake(0, -imageHeight, kUIScreenWidth , imageHeight);
            //设置图片的高度和宽度都改变(必须设置,否则只有高度改变)
        
            //将图片加入集合视图上
            [self.collectionView addSubview:_spaceImgView];
            

        
        
        //获得所有数据
        _addressLabel.text = mileage.travelContent;
        NSString *dataAndDays = [NSString stringWithFormat:@"%@/%@天",mileage.packDate,mileage.days];
        _dataLabel.text = dataAndDays;
        _distanceLabel.text = mileage.distance;
        

    };
    
   
    
}


//添加视图
-(void)loadViews{
    
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
    self.collectionView.alwaysBounceVertical = YES;
    
    //self.collectionView.alwaysBounceHorizontal = NO;
    _spaceImgView = [[UIImageView alloc] init];
    
    //打开图片视图的交互
    _spaceImgView.userInteractionEnabled = YES;
    
    //让子类自动布局
    _spaceImgView.autoresizesSubviews = YES;
    
    //创建返回按钮
    _returnBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    _returnBtn.frame = CGRectMake(2, 20, 30, 30);
    _returnBtn.backgroundColor = [UIColor lightGrayColor];
    _returnBtn.alpha = 0.5;
    [_returnBtn setBackgroundImage:[UIImage imageNamed:@"com_taobao_tae_sdk_web_view_title_bar_back.9.png"] forState:UIControlStateNormal];
    //给按钮绑定事件
    [_returnBtn addTarget:self action:@selector(returnAction:) forControlEvents:UIControlEventTouchUpInside];
    [_spaceImgView addSubview:_returnBtn];
    
    
    //创建目的地文本框
    _addressLabel = [[UILabel alloc] initWithFrame:CGRectMake(10,imageHeight-80, kUIScreenWidth-20, 20)];
    //自动布局,自适应顶部
    //_addressLabel.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
    [_spaceImgView addSubview:_addressLabel];
    _addressLabel.textColor = [UIColor whiteColor];

    //创建日期文本框
    _dataLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, imageHeight-50, kUIScreenWidth-20, 20)];
    //自动布局,自适应顶部
   //_dataLabel.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
    [_spaceImgView addSubview:_dataLabel];
    _dataLabel.textColor = [UIColor whiteColor];
    
    //创建距离文本框
    _distanceLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, imageHeight-20, kUIScreenWidth-20, 20)];
    //自动布局,自适应顶部
    //_distanceLabel .autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
    [_spaceImgView addSubview:_distanceLabel];
    _distanceLabel.textColor = [UIColor whiteColor];
    
    
    
}

//返回上个界面
-(void)returnAction:(UIButton *)sender{
    
    [self dismissViewControllerAnimated:YES completion:nil];
}


-(void)viewWillAppear:(BOOL)animated{
    

    //解析数据
    [[ShowInformationDataManager sharedShowInformationDataManager] analysiseDataByMileage:self.mileage];
    
    //刷新集合视图
    [ShowInformationDataManager sharedShowInformationDataManager].flash = ^(){
        [self.collectionView reloadData];
    };
    
}


//当滑动视图时,判断imageView的大小,改变图片视图的坐标和大小
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat y = scrollView.contentOffset.y;
    if (y<-imageHeight) {
        NSLog(@"%.2f",_spaceImgView.frame.size.height);
        CGRect frame = _spaceImgView.frame;
        frame.origin.y = y;
        frame.size.height = -y;
        _spaceImgView.frame = frame;
        
    }
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark <UICollectionViewDataSource>

//设置总的分区数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
   // NSLog(@"%ld",[ShowInformationDataManager sharedShowInformationDataManager].allLogs.count);
//根据日志数组的个数分区
    return [ShowInformationDataManager sharedShowInformationDataManager].allLogs.count;
    
}

//设置每个分区的item的个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    //根据分区数,获得每个分区的item的个数
    //获得日志对象
    Loglist *log = [ShowInformationDataManager sharedShowInformationDataManager].allLogs[section];
    //获得log日志对象的图片个数
    NSInteger count = log.imageUrls.count;
    return count;
}

//设置每个item的内容
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ShowInforCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    //根据日志对象
    Loglist *log = [ShowInformationDataManager sharedShowInformationDataManager].allLogs[indexPath.section];
    //获得此时的日志对象对应的图片url
    NSString *urlString = log.imageUrls[indexPath.item];
    //设置图片
    [cell.imgView sd_setImageWithURL:[NSURL URLWithString:urlString]];
    return cell;
}

//设置每个分区的头视图的大小
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
  CGSize size =  CGSizeMake(kUIScreenWidth, 100);
    return size;
}

//设置每个分区的尾视图的大小
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    CGSize size = CGSizeMake(kUIScreenWidth, 50);
    return size;
}

//设置每个item的大小
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    //根据日志对象的图片数组个数,判断item的大小
   //获得指定的日志对象
    Loglist *log = [ShowInformationDataManager sharedShowInformationDataManager].allLogs[indexPath.section];
    if(log.imageUrls.count > 1){
    CGSize size = CGSizeMake((kUIScreenWidth-20)/3, 100);
    return size;
    }
    else if(log.imageUrls.count == 1){
        CGSize size = CGSizeMake(kUIScreenWidth-20, 300);
        return size;
    }
    return CGSizeMake(0, 0);
}

//设置每一行之间的每个item的间距
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 10;
}


//设置每一行之间的距离
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 10;
}

//设置头视图或尾视图
-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
   //获得区头视图
    CollectionHeaderReusableView *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:reuseHeaderIdentifier forIndexPath:indexPath];
    
    //获得区尾视图
    CollectionFooterReusableView *footer = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:reuseFooterIdentifier forIndexPath:indexPath];
    
    //根据section获得日志对象
    Loglist *log = [ShowInformationDataManager sharedShowInformationDataManager].allLogs[indexPath.section];
 
    //设置区头视图的内容
    header.detailLabel.text = log.logcontent;
    
    //设置区尾视图内容
    NSString *pinLun =[NSString stringWithFormat:@"%ld",log.commentsNum];
   //设置评论按钮的标题
    [footer.pinLunBtn setTitle:pinLun forState:UIControlStateNormal];
    //绑定按钮事件
    [footer.pinLunBtn addTarget:self action:@selector(pinLunBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    //如果类型是区头视图
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
      return header;
    }
    
    if([kind isEqualToString:UICollectionElementKindSectionFooter]){
      return footer;
    }
    return nil;
}


//点击每个item,跳转到图片展示界面
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    //根据section获得每个日志对象
    Loglist *logList = [ShowInformationDataManager sharedShowInformationDataManager].allLogs[indexPath.section];
    
    //创建图片显示控制器
    ShowPhotoViewController *photoVC = [[ShowPhotoViewController alloc]init];
//    
    UINavigationController *photoNC = [[UINavigationController alloc] initWithRootViewController:photoVC];
    
    photoNC.navigationBar.backgroundColor = [UIColor lightGrayColor];
    
    //传值
    photoVC.log = logList;
    
    //跳转页面
    [self showDetailViewController:photoNC sender:nil];
    
  
    
}


//点击评论按钮事件,跳转到评论详情页面
-(void)pinLunBtnAction:(UIButton *)sender{
    //NSLog(@"%@",sender.titleLabel.text);
    
    //跳转到评论视图控制器中
    PinLunTableViewController *pinLnTVC = [[PinLunTableViewController alloc] init];
    
    //设置导航控制器
    UINavigationController *pinLunNC = [[UINavigationController alloc] initWithRootViewController:pinLnTVC];

    //根据按钮的标题判断日志对象
    for (Loglist *log in [ShowInformationDataManager sharedShowInformationDataManager].allLogs) {
        NSString *commentsNumber = [NSString stringWithFormat:@"%ld",log.commentsNum] ;
        if ([commentsNumber isEqualToString:sender.titleLabel.text] ) {
            //传值
            pinLnTVC.logList = log;
            break ;
        }
    }
    //跳转
    [self showViewController:pinLunNC sender:nil];
    
}

@end
