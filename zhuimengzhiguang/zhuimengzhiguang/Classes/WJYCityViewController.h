//
//  WJYCityViewController.h
//  zhuimengzhiguang
//
//  Created by 王建业 on 15/11/13.
//  Copyright © 2015年 王建业. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^ReloadBlock) (NSInteger,NSString*);
@interface WJYCityViewController : UIViewController

@property (nonatomic, strong) NSMutableArray *cityArray;
@property (nonatomic, copy) ReloadBlock reloadBlock;
@end
