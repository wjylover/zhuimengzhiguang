//
//  NSString+Characters.h
//  zhuimengzhiguang
//
//  Created by 王建业 on 15/11/17.
//  Copyright © 2015年 王建业. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Characters)



//讲汉字转换为拼音(无音标)

- (NSString *)pinyinOfString;





//汉字转换为拼音后，返回大写的首字母

- (NSString *)firstCharacterOfString;

@end
