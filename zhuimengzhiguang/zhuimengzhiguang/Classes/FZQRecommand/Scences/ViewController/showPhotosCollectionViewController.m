//
//  showPhotosCollectionViewController.m
//  zhuimengzhiguang
//
//  Created by lanou3g on 15/11/18.
//  Copyright © 2015年 王建业. All rights reserved.
//

#import "showPhotosCollectionViewController.h"

@interface showPhotosCollectionViewController ()<MONActivityIndicatorViewDelegate>

//暂存点击的cell
@property(nonatomic,strong)photoCollectionViewCell *photoCell;

//创建提示动画对象
@property(nonatomic,strong)MONActivityIndicatorView *indicatorView;

@end

@implementation showPhotosCollectionViewController

static NSString * const reuseIdentifier = @"photoCellID";

- (void)viewDidLoad {
    [super viewDidLoad];
  
    self.navigationController.navigationBarHidden = NO;
    
    self.navigationItem.title = @"旅者足迹";
    
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0.313 green:0.782 blue:1.000 alpha:1.000];
    
    //添加一个返回按钮
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back_arrow"] style:UIBarButtonItemStylePlain target:self action:@selector(returnAction:)];
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor whiteColor];

    
    self.collectionView.backgroundColor = [UIColor blackColor];
    
    // 注册cell
    [self.collectionView registerNib:[UINib nibWithNibName:@"photoCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:reuseIdentifier];
    
    //添加提示动画
    _indicatorView = [[MONActivityIndicatorView alloc] init];
    _indicatorView.delegate = self;
    _indicatorView.numberOfCircles = 3;
    _indicatorView.radius = 20;
    _indicatorView.internalSpacing = 3;
    _indicatorView.center = self.view.center;
    [_indicatorView startAnimating];
    [self.view addSubview:_indicatorView];

    
}


-(void)viewDidAppear:(BOOL)animated{
    //移除提示信息视图
    [_indicatorView removeFromSuperview];
    [_indicatorView stopAnimating];

}

#pragma mark - MONActivityIndicatorViewDelegate Methods

- (UIColor *)activityIndicatorView:(MONActivityIndicatorView *)activityIndicatorView
      circleBackgroundColorAtIndex:(NSUInteger)index {
    CGFloat red   = (arc4random() % 256)/255.0;
    CGFloat green = (arc4random() % 256)/255.0;
    CGFloat blue  = (arc4random() % 256)/255.0;
    CGFloat alpha = 1.0f;
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}

//返回上一个页面
-(void)returnAction:(UIBarButtonItem *)sender{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {

    return self.bigUrlStrings.count;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
    photoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    NSString *urlString = self.bigUrlStrings[indexPath.section];
    
    //NSLog(@"%@",urlString);
    
    NSURL *url = [NSURL URLWithString:urlString];
    
    [cell.bigPhotoImg sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"b6d39f2aa6651e4dcaadd4c7113d5350.jpg"]];
    cell.contentLabel.text = self.log.logcontent;
    
    //给保存按钮绑定保存事件
    [cell.saveBtn addTarget:self action:@selector(saveAction:) forControlEvents:UIControlEventTouchUpInside];
    
    //记录此次点击的cell
    _photoCell = cell;
    
    return cell;
}

//保存图片
-(void)saveAction:(UIButton *)sender{
    [self saveImage:_photoCell];
}


//收藏图片,将图片保存到iphone本地图库中
-(void)saveImage:(photoCollectionViewCell *)cell{
    /**
     *  将图片保存到iPhone本地相册
     *  UIImage *image            图片对象
     *  id completionTarget       响应方法对象
     *  SEL completionSelector    方法
     *  void *contextInfo
     */
    UIImageWriteToSavedPhotosAlbum(cell.bigPhotoImg.image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo{
    
    if(error == nil) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"message:@"已存入手机相册"delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定",nil];
        [alert show];
        
    }else{
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"message:@"保存失败"delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alert show];
    }
    
}




@end
