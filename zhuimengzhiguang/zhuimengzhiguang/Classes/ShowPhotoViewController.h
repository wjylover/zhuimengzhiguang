//
//  ShowPhotoViewController.h
//  zhuimengzhiguang
//
//  Created by lanou3g on 15/11/13.
//  Copyright © 2015年 王建业. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShowPhotoViewController : UIViewController

//接收上个页面传过来的日志对象
@property(nonatomic,strong)Loglist *log;

//创建一个存储图片的数组
@property(nonatomic,strong)NSArray *images;

@end
