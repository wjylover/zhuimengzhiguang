//
//  MyViewController.m
//  zhuimengzhiguang
//
//  Created by lanou3g on 15/11/13.
//  Copyright © 2015年 王建业. All rights reserved.
//

#import "MyViewController.h"
#import "CHTumblrMenuItemButton.h"
#import "WJYCollectViewController.h"
#import "WJYDataManager.h"
@interface MyViewController ()

//创建一个放置所有按钮的视图
@property(nonatomic,strong) CHTumblrMenuView *tumblrMenuView;

//创建一个提示框控制器对象
@property(nonatomic,strong) UIAlertController *alertController;


//创建一个加在窗口上的视图
@property(nonatomic,strong)UIView *dayView;

@end

@implementation MyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"设置";

}

- (void)viewWillDisappear:(BOOL)animated
{
    [_tumblrMenuView dismiss:self];
}
- (void)viewDidAppear:(BOOL)animated
{
    __weak typeof(self) temp = self;
    _tumblrMenuView = [[CHTumblrMenuView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 49)];
    
    
    _tumblrMenuView.backgroundColor = [UIColor colorWithWhite:0.902 alpha:1.000];
    // 背景图片
    
    // 头视图
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 64)];
    view.backgroundColor = [UIColor colorWithRed:0.313 green:0.782 blue:1.000 alpha:1.000];
    [_tumblrMenuView addSubview:view];
    // titel
    UILabel *titelLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 27, self.view.frame.size.width, 30)];
    titelLabel.textAlignment = NSTextAlignmentCenter;
    titelLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:17];
    titelLabel.text = @"设置";
    [view addSubview:titelLabel];
    [_tumblrMenuView addMenuItemWithTitle:@"我的收藏" andIcon:[UIImage imageNamed:@"soucang2"] andSelectedBlock:^{
        WJYCollectViewController *collectVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"CollectVC"];
        temp.hidesBottomBarWhenPushed = YES;

        [temp showViewController:collectVC sender:nil];
        temp.hidesBottomBarWhenPushed = NO;

    }];
    
    [_tumblrMenuView addMenuItemWithTitle:@"清除缓存" andIcon:[UIImage imageNamed:@"qingchu"]  andSelectedBlock:^{
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
        [_tumblrMenuView addMenuItemWithTitle:@"夜间模式" andIcon:[UIImage imageNamed:@"yejian"]  andSelectedBlock:^{
            if ([WJYDataManager sharedManager].isDay == NO) {
            [[temp.tumblrMenuView getButtons][2] titleLabel_].text = @"日间模式";
                [[temp.tumblrMenuView getButtons][2] iconView_].image = [UIImage imageNamed:@"rijian"];
            //将视图加载该应用程序的窗口上
            [[UIApplication sharedApplication].keyWindow addSubview:temp.dayView];
              
            //并将样式设为NO
            [WJYDataManager sharedManager].isDay = YES;
            }else{
                [[temp.tumblrMenuView getButtons][2] titleLabel_].text = @"夜间模式";
                 //移除在该应用程序的窗口上的视图
                [[temp.tumblrMenuView getButtons][2] iconView_].image = [UIImage imageNamed:@"yejian"];
                [temp.dayView removeFromSuperview];
                //并将样式设为YES
                [WJYDataManager sharedManager].isDay = NO;
            }
        }];
    // 修正图片文字
    if ([WJYDataManager sharedManager].isDay == YES) {
        [[temp.tumblrMenuView getButtons][2] titleLabel_].text = @"日间模式";
        [[temp.tumblrMenuView getButtons][2] iconView_].image = [UIImage imageNamed:@"rijian"];
    }


    [_tumblrMenuView addMenuItemWithTitle:@"关于我们" andIcon:[UIImage imageNamed:@"guanyuwomen"]  andSelectedBlock:^{

        
        
        
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
