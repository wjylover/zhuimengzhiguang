//
//  WJYScenerySpotViewController.h
//  zhuimengzhiguang
//
//  Created by 王建业 on 15/11/13.
//  Copyright © 2015年 王建业. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ScenerySpotContent;

@interface WJYScenerySpotViewController : UIViewController
@property (nonatomic, strong) UIImageView *headImageView;
@property (nonatomic, strong) ScenerySpotContent *scenery;
@property (nonatomic, strong) NSString *typeID;
@end
