//
//  ZWXXXList.m
//  Demo
//
//  Created by joywii on 14-9-9.
//  Copyright (c) 2014年 sohu. All rights reserved.
//

#import "ZWXXXList.h"

@implementation ZWXXXList

+ (id)shareXXXList
{
    static ZWXXXList *instanceList;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^
    {
        instanceList = [self restore];
        if (instanceList == nil)
        {
            instanceList = [[ZWXXXList alloc] init];
        }
    });
    return instanceList;
}
- (id)init
{
    self = [super init];
    if (self)
    {
        //初始化数据
        self.xxxList = [NSMutableArray array];
    }
    return self;
}
+ (instancetype)restore
{
    NSString *path = [DataPathForXXXList stringByAppendingPathComponent:@"books"];
    if ([[NSFileManager defaultManager] fileExistsAtPath:path])
    {
        return [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    }
    return nil;
}
-(id)initWithCoder:(NSCoder*)coder
{
    self = [super init];
    if (self)
    {
        self.xxxList = [coder decodeObjectForKey:@"xxxList"];
        if (self.xxxList == nil)
        {
            self.xxxList = [NSMutableArray array];
        }
    }
    return self;
}

-(void)encodeWithCoder:(NSCoder*)coder
{
    if (coder)
    {
        [coder encodeObject:self.xxxList forKey:@"xxxList"];
    }
}
- (void)synchronize
{
    NSString *path = [DataPathForXXXList stringByAppendingPathComponent:@"books"];
    NSString *dir = [path stringByDeletingLastPathComponent];
    if (![[NSFileManager defaultManager] fileExistsAtPath:dir])
    {
        [[NSFileManager defaultManager] createDirectoryAtPath:dir withIntermediateDirectories:YES attributes:nil error:nil];
    }
    [NSKeyedArchiver archiveRootObject:self toFile:path];
}
- (void)synchronizeAsync
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^
    {
        [self synchronize];
    });
}
@end
