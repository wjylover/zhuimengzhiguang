//
//  pinLun.h
//  zhuimengzhiguang
//
//  Created by lanou3g on 15/11/12.
//  Copyright © 2015年 王建业. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface pinLun : NSObject

//评论人
@property(nonatomic,copy)NSString *userName;
//头像url
@property(nonatomic,copy)NSString *photoUrl;
//评论
//@property(nonatomic,copy)NSString *content;
//时间
@property(nonatomic,copy)NSString *commentsTime;
//回复
@property(nonatomic,strong)NSString *backContent;



@end
