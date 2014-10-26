//
//  BeeCache.h
//  youwo
//
//  Created by Mac on 13-7-22.
//  Copyright (c) 2013年 sohu. All rights reserved.
//

#import <Foundation/Foundation.h>

#pragma mark -

@protocol BeeCacheProtocol<NSObject>

/*
 判断缓存是否存在
 @para key 缓存对应的key
 @return 存在返回yes
 */
- (BOOL)hasCached:(NSString *)key;

/*
 key所对应的缓存
 @para key 缓存对应的key
 @return 返回缓存内容(NSData)
 */
- (NSData *)dataForKey:(NSString *)key;
/*
 缓存key对应的数据
 @para data 缓存数据
 @para key 缓存的key
 */
- (void)saveData:(NSData *)data forKey:(NSString *)key;

/*
 key所对应的缓存
 @para key 缓存对应的key
 @return 返回缓存对象
 */
- (NSObject *)objectForKey:(NSString *)key;
/*
 缓存key对应的数据
 @para object 缓存对象
 @para key 缓存的key
 */
- (void)saveObject:(NSObject *)object forKey:(NSString *)key;

/*
 删除key对应的数据
 @para key 缓存的key
 */
- (void)deleteKey:(NSString *)key;

/*
 删除所有缓存
 */
- (void)deleteAll;

@end

#pragma mark -

@interface BeeFileCache : NSObject<BeeCacheProtocol>
{
	NSString *				_cachePath;
	NSString *				_cacheUser;
}

@property (nonatomic, strong) NSString *			cachePath;
@property (nonatomic, strong) NSString *			cacheUser;

+(BeeFileCache *)sharedFileCache;

/*
 序列化对象
 @para obj 要序列化的对象
 @return 序列化后的data
 */
- (NSData *)serialize:(NSObject *)obj;

/*
 反序列化
 @para data 反序列化的数据流
 @return 反序列化后的对象
 */
- (NSObject *)unserialize:(NSData *)data;

@end

#pragma mark -

@interface BeeMemoryCache : NSObject<BeeCacheProtocol>
{
	BOOL					_clearWhenMemoryLow; // 内存紧张时是否释放
	NSUInteger				_maxCacheCount;      // 最大缓存数量
	NSUInteger				_cachedCount;        // 当前缓存数量
	NSMutableArray *		_cacheKeys;          // 所有缓存所对应的key
	NSMutableDictionary *	_cacheObjs;          // 所有的缓存对象
}

@property (nonatomic, assign) BOOL					clearWhenMemoryLow;
@property (nonatomic, assign) NSUInteger			maxCacheCount;
@property (nonatomic, assign) NSUInteger			cachedCount;
@property (nonatomic, strong) NSMutableArray *		cacheKeys;
@property (nonatomic, strong) NSMutableDictionary *	cacheObjs;
+(BeeMemoryCache *)sharedMemoryCache;

@end
