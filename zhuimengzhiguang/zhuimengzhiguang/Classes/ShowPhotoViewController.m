//
//  ShowPhotoViewController.m
//  zhuimengzhiguang
//
//  Created by lanou3g on 15/11/13.
//  Copyright © 2015年 王建业. All rights reserved.
//

#import "ShowPhotoViewController.h"



@interface ShowPhotoViewController ()<MONActivityIndicatorViewDelegate,UIScrollViewDelegate,UIGestureRecognizerDelegate>

//创建滚动视图,使图片可以放大或缩小
@property(nonatomic,strong)UIScrollView *imgScrollView;

//创建一个视图对象,显示大图片
@property(nonatomic,strong)UIImageView *bigImgView;


//创建一个提示信息视图
@property(nonatomic,strong)MONActivityIndicatorView *indicatorView;



@end

@implementation ShowPhotoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
    self.navigationItem.title = @"旅者足迹";
    self.view.backgroundColor = [UIColor blackColor];
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:160/255.0 green:213/255.0 blue:243/255.0 alpha:1];

    
    //添加一个返回按钮
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"weibosdk_navigationbar_back.png"] style:UIBarButtonItemStylePlain target:self action:@selector(returnAction:)];
    
    //添加一个按钮
    UIButton *saveBtn = [[UIButton alloc] initWithFrame:CGRectMake(kUIScreenWidth-50, 5, 40, 35)];
    [self.navigationController.navigationBar addSubview:saveBtn];
    [saveBtn setImage:[UIImage imageNamed:@"iconfont-shoucang.png"] forState:UIControlStateNormal];
    [saveBtn addTarget:self action:@selector(saveImage:) forControlEvents:UIControlEventTouchUpInside];
}




//返回上一个页面
-(void)returnAction:(UIBarButtonItem *)sender{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

//收藏图片,将图片保存到iphone本地图库中
-(void)saveImage:(UIButton*)sender{
    /**
     *  将图片保存到iPhone本地相册
     *  UIImage *image            图片对象
     *  id completionTarget       响应方法对象
     *  SEL completionSelector    方法
     *  void *contextInfo
     */
    UIImageWriteToSavedPhotosAlbum(self.bigImgView.image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
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


-(void)viewWillAppear:(BOOL)animated{

    //显示导航栏
    self.navigationController.navigationBarHidden = NO;
    
    
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


-(void)viewDidAppear:(BOOL)animated{
    
      [self loadViews];
    
}

//加载视图
-(void)loadViews{
    
    //创建滚动视图
    _imgScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kUIScreenWidth, kUIScreenHeight)];
    _imgScrollView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:_imgScrollView];
    
    //创建一个图片视图
    _bigImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0,(kUIScreenHeight-64-300)/2, kUIScreenWidth,300)];
    
    [_bigImgView sd_setImageWithURL:[NSURL URLWithString:self.bigUrlString]];
    
    _bigImgView.contentMode = UIViewContentModeScaleAspectFill;
    
    //移除提示信息视图
    [_indicatorView removeFromSuperview];
    [_indicatorView stopAnimating];
    
// 给图片添加双击事件,恢复正常比例
    UITapGestureRecognizer *doubleTap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(doubleTap)];
    doubleTap.numberOfTapsRequired=2;//双击
    [_bigImgView addGestureRecognizer:doubleTap];
    
    //将图片视图加载滚动视图上
    [_imgScrollView addSubview:_bigImgView];
    
    //设置滚动视图的内容大小和图片视图的大小一样
    _imgScrollView.contentSize = _bigImgView.frame.size;
    
    //打开图片视图的交互
    _bigImgView.userInteractionEnabled = YES;
    
    //设置该滚动视图的最小的缩小比例和最大的放大比例
    _imgScrollView.minimumZoomScale = 0.5;
    _imgScrollView.maximumZoomScale = 2;
    
    _imgScrollView.alwaysBounceHorizontal = YES;
    _imgScrollView.alwaysBounceVertical = YES;
    
    //设置滚动视图的代理对象
    _imgScrollView.delegate = self;

    
    
    
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


#pragma mark ---- UIScrollViewDelegate

//实现缩放的协议方法

//返回要缩放的视图
-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.bigImgView;
}


//实现缩放
-(void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale
{
    //获得要缩放的视图的frame
    CGRect newFrame = view.frame;
    
    //判断缩放后的视图的size是否大于滚动视图的frame
    if(view.frame.size.width < scrollView.frame.size.width)
    {
        newFrame.origin.x = (scrollView.frame.size.width-view.frame.size.width)/2;
    }
    else{
        newFrame.origin.x = 0;
    }
    if(view.frame.size.height < scrollView.frame.size.height){
        newFrame.origin.y = (scrollView.frame.size.height-64-view.frame.size.height)/2;
    }
    else{
        newFrame.origin.y = 0;
    }
    
    //将缩放后的frame赋值给缩放视图
    view.frame = newFrame;
}


//双击图片恢复原来大小
-(void)doubleTap{
     [self normal];
}

//恢复正常比例
-(void)normal{
    
    //将缩放比例设置为原比例
    self.imgScrollView.zoomScale = 1.0;
    
    //还原比例后将视图设置为原来图片视图的大小
    self.bigImgView.frame = CGRectMake(0,(kUIScreenHeight-64-300)/2, kUIScreenWidth,300);
   

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
