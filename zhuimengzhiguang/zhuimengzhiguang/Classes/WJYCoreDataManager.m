//
//  WJYCoreDataManager.m
//  zhuimengzhiguang
//
//  Created by 王建业 on 15/11/16.
//  Copyright © 2015年 王建业. All rights reserved.
//

#import "WJYCoreDataManager.h"
#import <CoreData/CoreData.h>
#import "Collect.h"
#import "Collect.h"
#import "AppDelegate.h"

@interface WJYCoreDataManager ()

// 属性接收AppDelegate里面的被管理对象上下文
@property (nonatomic, retain) NSManagedObjectContext *myObjectContext;
// 接收所有查询出来的收藏内容
@property (nonatomic, strong) NSMutableArray *allCollectArray;

@end

@implementation WJYCoreDataManager

+ (instancetype)sharedManager
{
    static WJYCoreDataManager *dataManger = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dataManger = [WJYCoreDataManager new];
        
    });
    return dataManger;
}

-(instancetype)init
{
    if (self = [super init]) {
        // 获取AppDelegate里面的被管理对象上下文
        // 1.获取AppDelegate
        AppDelegate *appdelegate = [UIApplication sharedApplication].delegate;
        
        // 2.获取被管理对象上下文
        self.myObjectContext = appdelegate.managedObjectContext;
    }
    return self;
}

- (void)addCollect:(NSString *)typeID
{
    //创建描述对象
    NSEntityDescription *description = [NSEntityDescription entityForName:@"Collect" inManagedObjectContext:self.myObjectContext];
    
    //创建ComicsCollect对象
    Collect *collect = [[Collect alloc] initWithEntity:description insertIntoManagedObjectContext:self.myObjectContext];
    collect.typeID = typeID;
    //保存操作
    [self.myObjectContext save:nil];
}

// 删除表
- (void)deleteCollectTabel
{
    NSEntityDescription *description = [NSEntityDescription entityForName:@"Collect" inManagedObjectContext:self.myObjectContext];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setIncludesPropertyValues:NO];
    [request setEntity:description];
    NSError *error = nil;
    NSArray *datas = [_myObjectContext executeFetchRequest:request error:&error];
    if (!error && datas && [datas count])
    {
        for (NSManagedObject *obj in datas)
        {
            [_myObjectContext deleteObject:obj];
        }
        if (![_myObjectContext save:&error])
        {
        }
    }
}
// 查询所有收藏
- (NSArray *)getAllCollect
{
    // 搜索类
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    
    // 实体描述
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Collect" inManagedObjectContext:self.myObjectContext];
    [fetchRequest setEntity:entity];
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"typeID" ascending:YES];
    [fetchRequest setSortDescriptors:[NSArray arrayWithObjects:sortDescriptor, nil]];
    
    // 执行查询请求
    NSError *error = nil;
    NSArray *fetchedObjects = [self.myObjectContext executeFetchRequest:fetchRequest error:&error];
    if (fetchedObjects == nil) {
        return nil;
    }else{
        return fetchedObjects;
        
    }
    
    
    return nil;
}

- (Collect *)getCollectWithTypeID:(NSString *)typeID
{
    // 搜索类
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    
    // 实体描述
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Collect" inManagedObjectContext:self.myObjectContext];
    [fetchRequest setEntity:entity];
    
    // 查找条件
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"typeID = %@", typeID];
    [fetchRequest setPredicate:predicate];
    
    // 执行查询请求
    NSError *error = nil;
    NSArray *fetchedObjects = [self.myObjectContext executeFetchRequest:fetchRequest error:&error];
    if (fetchedObjects.count == 0) {
        return nil;
    }else{
        return fetchedObjects[0];
        
    }

}
@end
