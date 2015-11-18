//
//  NSString+Characters.m
//  zhuimengzhiguang
//
//  Created by 王建业 on 15/11/17.
//  Copyright © 2015年 王建业. All rights reserved.
//

#import "NSString+Characters.h"


@implementation NSString (Characters)



//讲汉字转换为拼音

- (NSString *)pinyinOfString

{
    
    NSMutableString * string = [[NSMutableString alloc] initWithString:self];
    
    
    
    CFRange range = CFRangeMake(0, [self length]);
    
    
    
    // 汉字转换为拼音,并去除音调
    
    if ( ! CFStringTransform((__bridge CFMutableStringRef) string, &range, kCFStringTransformMandarinLatin, NO) ||
        
        ! CFStringTransform((__bridge CFMutableStringRef) string, &range, kCFStringTransformStripDiacritics, NO)) {
        
        return @"";
        
    }
    
    
    
    return string;
    
}



//汉字转换为拼音后，返回大写的首字母

- (NSString *)firstCharacterOfString

{
    
    
    
    NSMutableString * first = [[NSMutableString alloc] initWithString:[self substringWithRange:NSMakeRange(0, 1)]];
    
    
    
    CFRange range = CFRangeMake(0, 1);
    
    
    
    // 汉字转换为拼音,并去除音调
    
    if ( ! CFStringTransform((__bridge CFMutableStringRef) first, &range, kCFStringTransformMandarinLatin, NO) ||
        
        ! CFStringTransform((__bridge CFMutableStringRef) first, &range, kCFStringTransformStripDiacritics, NO)) {
        
        return @"";
        
    }
    
    
    
    NSString * result;
    
    result = [first substringWithRange:NSMakeRange(0, 1)];
    
    
    
    return result.uppercaseString;
    
}

@end

