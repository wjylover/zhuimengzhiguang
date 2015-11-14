//
//  PinLunTableViewController.h
//  zhuimengzhiguang
//
//  Created by lanou3g on 15/11/12.
//  Copyright © 2015年 王建业. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Loglist;

@interface PinLunTableViewController : UITableViewController


//接收上个页面的日志对象
@property(nonatomic,strong)Loglist *logList;

@end
