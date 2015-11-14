//
//  FZQHeader.h
//  zhuimengzhiguang
//
//  Created by lanou3g on 15/11/9.
//  Copyright © 2015年 王建业. All rights reserved.
//

#ifndef FZQHeader_h
#define FZQHeader_h

//主屏幕的高和宽
#define kUIScreenWidth [UIScreen mainScreen].bounds.size.width
#define kUIScreenHeight [UIScreen mainScreen].bounds.size.height

//底片图片的高
#define imageHeight 200


//推荐页面

//参数:page,每次刷新一次，page增加一次，page从0开始
#define kRecommandURL @"http://api.xingzhe01.com/xingzhe/home/recommended?&page="


//点击每个推荐cell，进入详情页面
//参数:journeyId,每个评论的journeyId
#define kRecommandInformationURL @"http://api.xingzhe01.com/xingzhe/journey/details2?action=journey%2Fdetails2&journeyId="


//评论接口
//参数:logId,每个cell的评论
#define kDetailRecommandURL @"http://api.xingzhe01.com/xingzhe/personal/comments_details?logId="

#define kDetailRecommandURL1 @"&commentId=0&redType=-1&flag=0&successToken=?&action=%2Fpersonal%2Fcomments_details"


//留言板
#define kMessageURL @"http://api.xingzhe01.com/xingzhe/message/list2?&action=%2Fmessage%2Flist2&lastMessageId=0"
#endif /* FZQHeader_h */
