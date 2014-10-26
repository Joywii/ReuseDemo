//
//  BeeSystemInfo.h
//  youwo
//
//  Created by Mac on 13-7-22.
//  Copyright (c) 2013年 sohu. All rights reserved.
//

#import <Foundation/Foundation.h>


#if (TARGET_OS_IPHONE || TARGET_IPHONE_SIMULATOR)

#define IOS7_OR_LATER	( [[[UIDevice currentDevice] systemVersion] compare:@"7.0"] != NSOrderedAscending )
#define IOS6_OR_LATER	( [[[UIDevice currentDevice] systemVersion] compare:@"6.0"] != NSOrderedAscending )
#define IOS5_OR_LATER	( [[[UIDevice currentDevice] systemVersion] compare:@"5.0"] != NSOrderedAscending )
#define IOS4_OR_LATER	( [[[UIDevice currentDevice] systemVersion] compare:@"4.0"] != NSOrderedAscending )
#define IOS3_OR_LATER	( [[[UIDevice currentDevice] systemVersion] compare:@"3.0"] != NSOrderedAscending )

#else	// #if (TARGET_OS_IPHONE || TARGET_IPHONE_SIMULATOR)

#define IOS7_OR_LATER	(NO)
#define IOS6_OR_LATER	(NO)
#define IOS5_OR_LATER	(NO)
#define IOS4_OR_LATER	(NO)
#define IOS3_OR_LATER	(NO)

#endif	// #if (TARGET_OS_IPHONE || TARGET_IPHONE_SIMULATOR)
