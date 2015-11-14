//
//  Loglist.h
//  zhuimengzhiguang
//
//  Created by lanou3g on 15/11/10.
//  Copyright © 2015年 王建业. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Loglist : NSObject

//日志Id
@property(nonatomic,assign)NSInteger logId;
//日志内容
@property(nonatomic,copy)NSString *logcontent;
//小图片url
@property(nonatomic,strong)NSArray *imageUrls;
//大图片url
@property(nonatomic,strong)NSArray *bigImageUrls;
//点赞数
@property(nonatomic,assign)NSInteger likeNum;
//评论数
@property(nonatomic,assign)NSInteger commentsNum;






@end
