//
//  User.h
//  zhuimengzhiguang
//
//  Created by lanou3g on 15/11/9.
//  Copyright © 2015年 王建业. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject


//声明属性

//用户Id
@property(nonatomic,assign) NSInteger userId ;
//用户名
@property(nonatomic,copy) NSString *userName;
//头像图片url
@property(nonatomic,copy) NSString *photoUrl;
//登陆时间
@property(nonatomic,copy) NSString *loginTime;
//目的地
@property(nonatomic,strong) NSString *distanceOrlocation;


//空间照片url
@property(nonatomic,strong)NSString *spaceImage;




@end
