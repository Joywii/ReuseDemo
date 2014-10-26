
#import "BeeSystemInfo.h"
#import "BeeSandbox.h"
#import "BeeCache.h"


#pragma mark -

#define DEFAULT_MAX_COUNT	(48)

#pragma mark -

@interface BeeFileCache(Private)
- (NSString *)cacheFileName:(NSString *)uniqueID;
@end

#pragma mark -

@implementation BeeFileCache

@synthesize cachePath = _cachePath;
@synthesize cacheUser = _cacheUser;

+(BeeFileCache *)sharedFileCache
{
    static BeeFileCache *fileCache = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        fileCache = [[BeeFileCache alloc] init];
    });
    return fileCache;
}
- (id)init
{
	self = [super init];
	if ( self )
	{
		self.cacheUser = @"";
//        self.cachePath = [NSString stringWithFormat:@"%@/%@/cache/", [BeeSandbox libCachePath], [BeeSystemInfo appVersion]];
		self.cachePath = [NSString stringWithFormat:@"%@/%@/", [BeeSandbox libCachePath],kAppName];
	}
	return self;
}

- (void)dealloc
{
	[NSObject cancelPreviousPerformRequestsWithTarget:self];
}

- (NSString *)cacheFileName:(NSString *)key
{
	NSString * pathName = nil;
	if ( self.cacheUser && [self.cacheUser length] )
	{
		pathName = [self.cachePath stringByAppendingFormat:@"%@/", self.cacheUser];
	}
	else
	{
		pathName = self.cachePath;
	}
	
	if ( NO == [[NSFileManager defaultManager] fileExistsAtPath:pathName] )
	{
		[[NSFileManager defaultManager] createDirectoryAtPath:pathName
								  withIntermediateDirectories:YES
												   attributes:nil
														error:NULL];
	}
    
	return [pathName stringByAppendingString:key];
}

- (BOOL)hasCached:(NSString *)key
{
	return [[NSFileManager defaultManager] fileExistsAtPath:[self cacheFileName:key]];
}

- (NSData *)dataForKey:(NSString *)key
{
	NSLog( @"load cache, %@", key );
	
	NSString * filePath = [self cacheFileName:key];
	return [NSData dataWithContentsOfFile:filePath];
}

- (void)saveData:(NSData *)data forKey:(NSString *)key
{
	if ( nil == data )
	{
		[self deleteKey:key];
	}
	else
	{
		[data writeToFile:[self cacheFileName:key] options:NSDataWritingAtomic error:NULL];
	}
}

- (NSData *)serialize:(id)obj
{
	if ( [obj isKindOfClass:[NSData class]] )
		return obj;

    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:obj];
    
    return data;
}

- (id)unserialize:(NSData *)data
{
    if (!data) {
        return nil;
    }
    id object = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    return object;
}

- (NSObject *)objectForKey:(NSString *)key
{
	NSData * data = [self dataForKey:key];
	if ( data )
	{
		return [self unserialize:data];
	}
    
	return nil;
}

- (void)saveObject:(NSObject *)object forKey:(NSString *)key
{
	if ( nil == object )
	{
		[self deleteKey:key];
	}
	else
	{
		NSData * data = [self serialize:object];
		if ( data )
		{
			[self saveData:data forKey:key];
		}
	}
}

- (void)deleteKey:(NSString *)key
{
	[[NSFileManager defaultManager] removeItemAtPath:[self cacheFileName:key] error:nil];
}

- (void)deleteAll
{
	[[NSFileManager defaultManager] removeItemAtPath:_cachePath error:NULL];
	[[NSFileManager defaultManager] createDirectoryAtPath:_cachePath
							  withIntermediateDirectories:YES
											   attributes:nil
													error:NULL];
}

@end

#pragma mark -

@implementation BeeMemoryCache

@synthesize clearWhenMemoryLow = _clearWhenMemoryLow;
@synthesize maxCacheCount = _maxCacheCount;
@synthesize cachedCount = _cachedCount;
@synthesize cacheKeys = _cacheKeys;
@synthesize cacheObjs = _cacheObjs;

+(BeeMemoryCache *)sharedMemoryCache
{
    static BeeMemoryCache *memCache = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        memCache = [[BeeMemoryCache alloc] init];
    });
    return memCache;
}

- (id)init
{
	self = [super init];
	if ( self )
	{
		_clearWhenMemoryLow = YES;
		_maxCacheCount = DEFAULT_MAX_COUNT;
		_cachedCount = 0;
		
		_cacheKeys = [[NSMutableArray alloc] init];
		_cacheObjs = [[NSMutableDictionary alloc] init];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveMemoryWorning) name:UIApplicationDidReceiveMemoryWarningNotification object:nil];
	}
    
	return self;
}

- (void)dealloc
{
	[[NSNotificationCenter defaultCenter] removeObserver:self];
	
	[_cacheObjs removeAllObjects];
	[_cacheKeys removeAllObjects];
}

- (BOOL)hasCached:(NSString *)key
{
	return [_cacheObjs objectForKey:key] ? YES : NO;
}

- (NSData *)dataForKey:(NSString *)key
{
	NSObject * obj = [self objectForKey:key];
	if ( obj && [obj isKindOfClass:[NSData class]] )
	{
		return (NSData *)obj;
	}
	
	return nil;
}

- (void)saveData:(NSData *)data forKey:(NSString *)key
{
	[self saveObject:data forKey:key];
}

- (NSObject *)objectForKey:(NSString *)key
{
	return [_cacheObjs objectForKey:key];
}

- (void)saveObject:(NSObject *)object forKey:(NSString *)key
{
	if ( nil == key )
		return;
	
	if ( nil == object )
		return;
	
	_cachedCount += 1;
    
	while ( _cachedCount >= _maxCacheCount )
	{
		NSString * tempKey = [_cacheKeys objectAtIndex:0];
        
		[_cacheObjs removeObjectForKey:tempKey];
		[_cacheKeys removeObjectAtIndex:0];
        
		_cachedCount -= 1;
	}
    
	[_cacheKeys addObject:key];
	[_cacheObjs setObject:object forKey:key];
}

- (void)deleteKey:(NSString *)key
{
	if ( [_cacheObjs objectForKey:key] )
	{
		[_cacheKeys removeObjectIdenticalTo:key];
		[_cacheObjs removeObjectForKey:key];
        
		_cachedCount -= 1;
	}
}

- (void)deleteAll
{
	[_cacheKeys removeAllObjects];
	[_cacheObjs removeAllObjects];
	
	_cachedCount = 0;
}
- (void)receiveMemoryWorning
{
    if ( _clearWhenMemoryLow )
    {
        [self deleteAll];
    }
}
@end
