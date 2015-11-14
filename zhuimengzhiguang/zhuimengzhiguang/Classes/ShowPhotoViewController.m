//
//  ShowPhotoViewController.m
//  zhuimengzhiguang
//
//  Created by lanou3g on 15/11/13.
//  Copyright © 2015年 王建业. All rights reserved.
//

#import "ShowPhotoViewController.h"

@interface ShowPhotoViewController ()<MONActivityIndicatorViewDelegate>

//创建一个图片内容视图
@property(nonatomic,strong)PhotoCotentView *contentView;

//创建一个存储图片的数组
@property(nonatomic,strong)NSArray *images;

//创建一个存储图片链接的数组
@property(nonatomic,strong)NSArray *netImagesUrl;

//创建一个提示信息视图
@property(nonatomic,strong)MONActivityIndicatorView *indicatorView;
@end

@implementation ShowPhotoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
      self.navigationItem.title = @"旅者足迹";
    
    _contentView = [[PhotoCotentView alloc] initWithFrame:CGRectMake(0, 65, kUIScreenWidth, kUIScreenHeight-64)];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_contentView];

    _netImagesUrl = self.log.bigImageUrls;
    
    //添加一个返回按钮
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"weibosdk_navigationbar_back.png"] style:UIBarButtonItemStylePlain target:self action:@selector(returnAction:)];
    
 
    
}


//返回上一个页面
-(void)returnAction:(UIBarButtonItem *)sender{
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

-(void)viewWillAppear:(BOOL)animated{

    //添加提示动图
    _indicatorView = [[MONActivityIndicatorView alloc] init];
    _indicatorView.delegate = self;
        _indicatorView.numberOfCircles = 3;
        _indicatorView.radius = 20;
        _indicatorView.internalSpacing = 3;
        _indicatorView.center = self.view.center;
        [_indicatorView startAnimating];
        [self.view addSubview:_indicatorView];
    
    
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

//显示数据
-(void)viewDidAppear:(BOOL)animated{
    
    //展示数据
    [self contentViewDataPrepare];
    
    //事件
    [self event];
    
    //移除提示信息视图
    [_indicatorView removeFromSuperview];
    [_indicatorView stopAnimating];
    

}

/** 展示数据 */
-(void)contentViewDataPrepare{
    
    _contentView.images =self.images;
}



/** 事件 */
-(void)event{
    __weak typeof(self) temp = self;
    _contentView.ClickImageBlock = ^(NSUInteger index){
        
        //本地图片展示
        [temp localImageShow:index];
        
    
    };
}

/*
 *  本地图片展示
 */
-(void)localImageShow:(NSUInteger)index{
    
    __weak typeof(self) weakSelf=self;
    
    [PhotoBroswerVC show:self type:PhotoBroswerVCTypeZoom index:index photoModelBlock:^NSArray *{
        
        NSArray *localImages = weakSelf.images;
        
        NSMutableArray *modelsM = [NSMutableArray arrayWithCapacity:localImages.count];
        for (NSUInteger i = 0; i< localImages.count; i++) {
            
            PhotoModel *pbModel=[[PhotoModel alloc] init];
            pbModel.mid = i + 1;
            pbModel.desc = self.log.logcontent;
            pbModel.image = localImages[i];
            
            //源frame
            UIImageView *imageV =(UIImageView *) weakSelf.contentView.subviews[i];
            pbModel.sourceImageView = imageV;
            
            [modelsM addObject:pbModel];
        }
        
        return modelsM;
    }];
}


-(NSArray *)images{
    if (!_images ) {
        
            NSMutableArray *arrayM = [NSMutableArray array];
            for (NSString *urlString in _netImagesUrl) {
                //获得网络图片
                NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:urlString]];
                UIImage *image = [UIImage imageWithData:data];
               
                [arrayM addObject:image];
                
            }
    
        _images = arrayM;
                
        
      
    }
    return _images;
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
