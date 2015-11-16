//
//  WJYMapHeadView.h
//  zhuimengzhiguang
//
//  Created by 王建业 on 15/11/14.
//  Copyright © 2015年 王建业. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface WJYMapHeadView : UIView

@property (strong, nonatomic) IBOutlet UILabel *scoreLabel;
@property (strong, nonatomic) IBOutlet UILabel *enjoyLabel;
@property (strong, nonatomic) IBOutlet UIView *mapBackView;
@property (strong, nonatomic) IBOutlet UILabel *addressLabel;

@end
