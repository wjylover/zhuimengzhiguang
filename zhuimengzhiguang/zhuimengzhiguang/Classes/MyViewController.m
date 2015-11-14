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

@end

@implementation MyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    
        _tumblrMenuView = [[CHTumblrMenuView alloc]initWithFrame:CGRectMake(0, kUIScreenHeight-200, kUIScreenWidth, kUIScreenWidth-200)];
    
        _tumblrMenuView.backgroundColor = [UIColor colorWithRed:46/255.0 green:62/255.0 blue:82/255.0 alpha:1];
    
    
        [_tumblrMenuView addMenuItemWithTitle:@"我的收藏" andIcon:[UIImage imageNamed:@"save.png"] andSelectedBlock:^{
            NSLog(@"收藏按钮");
        }];
    
        __weak typeof(self) temp = self;
        [_tumblrMenuView addMenuItemWithTitle:@"清除缓存" andIcon:[UIImage imageNamed:@"clean.png"]  andSelectedBlock:^{
            NSLog(@"清除缓存");
    
            //获得该应用程序的路径
            NSString *path = NSHomeDirectory();
            NSLog(@"%@",path);
    
            //创建提示框控制器
            _alertController = [UIAlertController alertControllerWithTitle:@"提示信息" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
            //创建按钮点击对象
            UIAlertAction *ac1 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                NSLog(@"取消");
            }];
    
            UIAlertAction *ac2 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    
               [temp clearCache:path];
                NSLog(@"确定");
            }];
    
            [temp.alertController addAction:ac1];
            [temp.alertController addAction:ac2];
    
            [temp presentViewController:temp.alertController animated:YES completion:nil];
    
        }];
    
        [_tumblrMenuView addMenuItemWithTitle:@"夜间模式" andIcon:[UIImage imageNamed:@"night.jpg"]  andSelectedBlock:^{
            NSLog(@"夜间模式");
    
        }];
        [_tumblrMenuView addMenuItemWithTitle:@"关于我们" andIcon:[UIImage imageNamed:@"fff.jpg"]  andSelectedBlock:^{
            NSLog(@"Link selected");
    
        }];
        [_tumblrMenuView addMenuItemWithTitle:@"意见箱" andIcon:[UIImage imageNamed:@"ideas.jpg"]  andSelectedBlock:^{
            NSLog(@"意见箱");
            
        }];
        
        [_tumblrMenuView show];
    
}

//点击按钮,出现所有点击按钮
- (IBAction)MenuAction:(UIButton *)sender {
    
//    _tumblrMenuView = [[CHTumblrMenuView alloc]init];
//    
//    _tumblrMenuView.backgroundColor = [UIColor colorWithRed:46/255.0 green:62/255.0 blue:82/255.0 alpha:1];
//
//    
//    [_tumblrMenuView addMenuItemWithTitle:@"我的收藏" andIcon:[UIImage imageNamed:@"save.png"] andSelectedBlock:^{
//        NSLog(@"收藏按钮");
//    }];
//    
//    __weak typeof(self) temp = self;
//    [_tumblrMenuView addMenuItemWithTitle:@"清除缓存" andIcon:[UIImage imageNamed:@"clean.png"]  andSelectedBlock:^{
//        NSLog(@"清除缓存");
//        
//        //获得该应用程序的路径
//        NSString *path = NSHomeDirectory();
//        NSLog(@"%@",path);
//        
//        //创建提示框控制器
//        _alertController = [UIAlertController alertControllerWithTitle:@"提示信息" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
//        
//        //创建按钮点击对象
//        UIAlertAction *ac1 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
//            NSLog(@"取消");
//        }];
//        
//        UIAlertAction *ac2 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//            
//           [temp clearCache:path];
//            NSLog(@"确定");
//        }];
//        
//        [temp.alertController addAction:ac1];
//        [temp.alertController addAction:ac2];
//        
//        [temp presentViewController:temp.alertController animated:YES completion:nil];
//        
//    }];
//    
//    [_tumblrMenuView addMenuItemWithTitle:@"夜间模式" andIcon:[UIImage imageNamed:@"night.jpg"]  andSelectedBlock:^{
//        NSLog(@"夜间模式");
//        
//    }];
//    [_tumblrMenuView addMenuItemWithTitle:@"关于我们" andIcon:[UIImage imageNamed:@"fff.jpg"]  andSelectedBlock:^{
//        NSLog(@"Link selected");
//        
//    }];
//    [_tumblrMenuView addMenuItemWithTitle:@"意见箱" andIcon:[UIImage imageNamed:@"ideas.jpg"]  andSelectedBlock:^{
//        NSLog(@"意见箱");
//        
//    }];
//    
//    [_tumblrMenuView show];
    
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



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
