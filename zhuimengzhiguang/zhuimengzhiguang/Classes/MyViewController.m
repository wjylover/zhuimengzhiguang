//
//  MyViewController.m
//  zhuimengzhiguang
//
//  Created by lanou3g on 15/11/13.
//  Copyright © 2015年 王建业. All rights reserved.
//

#import "MyViewController.h"

@interface MyViewController ()

//创建一个放置所有按钮的视图
@property(nonatomic,strong)CHTumblrMenuView *tumblrMenuView;

//创建一个提示框控制器对象
@property(nonatomic,strong)UIAlertController *alertController;

//创建一个BOOL值,判断此时的应用程序是否是夜间或日间模式 YES:日间模式 NO:夜间模式
@property(nonatomic,assign)BOOL isDay;

//创建一个加在窗口上的视图
@property(nonatomic,strong)UIView *dayView;

@end

@implementation MyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    //默认判断值是YES
    _isDay = YES;
    
    
    
    
    
    
}




//点击按钮,出现所有点击按钮
- (IBAction)MenuAction:(UIButton *)sender {
    
    _tumblrMenuView = [[CHTumblrMenuView alloc]init];
    
    _tumblrMenuView.backgroundColor = [UIColor colorWithRed:46/255.0 green:62/255.0 blue:82/255.0 alpha:0.3];

    
    [_tumblrMenuView addMenuItemWithTitle:@"我的收藏" andIcon:[UIImage imageNamed:@"save.png"] andSelectedBlock:^{
        NSLog(@"收藏按钮");
    }];
    
    __weak typeof(self) temp = self;
    [_tumblrMenuView addMenuItemWithTitle:@"清除缓存" andIcon:[UIImage imageNamed:@"clean.jpg"]  andSelectedBlock:^{
        NSLog(@"清除缓存");
        
        //获得该应用程序的缓存路径
         NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        NSLog(@"%@",cachePath);
        
        //计算文件缓存的大小
        CGFloat cacheSize = [temp folderSizeAtPath:cachePath];
        NSLog(@"%.2f",cacheSize);
        
        NSString *cacheSizeString = [NSString stringWithFormat:@"是否要清除%.2fM缓存内容",cacheSize];
        
        //创建提示框控制器
        _alertController = [UIAlertController alertControllerWithTitle:@"提示信息" message:cacheSizeString preferredStyle:UIAlertControllerStyleActionSheet];
        
        //创建按钮点击对象
        UIAlertAction *ac1 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            NSLog(@"取消");
        }];
        
        UIAlertAction *ac2 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            //清除缓存
           [temp clearCache:cachePath];
            NSLog(@"清除缓存成功");
        }];
        
        [temp.alertController addAction:ac1];
        [temp.alertController addAction:ac2];
        
        [temp presentViewController:temp.alertController animated:YES completion:nil];
        
    }];
    
    //判断此时的模式
    
    //如果是日间模式,则显示夜间模式的样式
    if (_isDay == YES) {
        [_tumblrMenuView addMenuItemWithTitle:@"夜间模式" andIcon:[UIImage imageNamed:@"night.jpg"]  andSelectedBlock:^{
            NSLog(@"夜间模式");
            
            //将视图加载该应用程序的窗口上
            [[UIApplication sharedApplication].keyWindow addSubview:temp.dayView];
            
            //并将样式设为NO
            _isDay = NO;
        }];
    }
    //如果是夜间模式,则显示日间模式的样式
    else{
        [_tumblrMenuView addMenuItemWithTitle:@"日间模式" andIcon:[UIImage imageNamed:@"sun.png"]  andSelectedBlock:^{
            NSLog(@"日间模式");
            
            //移除在该应用程序的窗口上的视图
            [temp.dayView removeFromSuperview];
            
            //并将样式设为YES
            _isDay = YES;

        }];
         
    }
    
    
    [_tumblrMenuView addMenuItemWithTitle:@"意见箱" andIcon:[UIImage imageNamed:@"ideas.jpg"]  andSelectedBlock:^{
        NSLog(@"意见箱");
        
        //创建意见箱控制器对象
        IdeaViewController *ideaVC = [[IdeaViewController alloc] initWithNibName:@"IdeaViewController" bundle:nil];
        
        //设置变换样式
      ideaVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        
        //跳转
        [temp presentViewController:ideaVC animated:YES completion:nil];
        
        
        
        
    }];
    
    [_tumblrMenuView show];
    
}


//计算单个文件的大小
-(float)fileSizeAtPath:(NSString *)path{
    NSFileManager *fileManager=[NSFileManager defaultManager];
    if([fileManager fileExistsAtPath:path]){
        long long size=[fileManager attributesOfItemAtPath:path error:nil].fileSize;
        return size/1024.0/1024.0;
    }
    return 0;
}

//计算目录大小
-(float)folderSizeAtPath:(NSString *)path{
    NSFileManager *fileManager=[NSFileManager defaultManager];
    float folderSize;
    if ([fileManager fileExistsAtPath:path]) {
        NSArray *childerFiles=[fileManager subpathsAtPath:path];
        for (NSString *fileName in childerFiles) {
            NSString *absolutePath=[path stringByAppendingPathComponent:fileName];
            folderSize +=[self fileSizeAtPath:absolutePath];
        }
    //SDWebImage框架自身计算缓存的实现
        folderSize+=[[SDImageCache sharedImageCache] getSize]/1024.0/1024.0;
        return folderSize;
    }
    return 0;
}

//清除缓存
-(void)clearCache:(NSString *)path{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:path]) {
        NSArray *childFiles = [fileManager subpathsAtPath:path];
        for (NSString *fileName in childFiles) {
            NSString *absolutePath = [path stringByAppendingPathComponent:fileName];
            [fileManager removeItemAtPath:absolutePath error:nil];
            
        }
    }
    [[SDImageCache sharedImageCache] cleanDisk];
}


//懒加载
-(UIView *)dayView{
    if (!_dayView) {
        _dayView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _dayView.backgroundColor = [UIColor blackColor];
        _dayView.alpha = 0.5;
        _dayView.userInteractionEnabled = NO;
    }
    return _dayView;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
