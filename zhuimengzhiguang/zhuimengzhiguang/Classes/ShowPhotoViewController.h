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

//接收上个页面传过来的大图片的网址
@property(nonatomic,copy)NSString *bigUrlString;

@end
