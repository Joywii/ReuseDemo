//
//  SDWebImageCombinedOperation.m
//  KuaiZhanManager
//
//  Created by robbie on 14-4-15.
//  Copyright (c) 2014年 sohu. All rights reserved.
//

#import "SDWebImageCombinedOperation.h"

@implementation SDWebImageCombinedOperation

- (void)setCancelBlock:(void (^)())cancelBlock
{
    if (self.isCancelled) {
        if (cancelBlock) cancelBlock();
    }
    else {
        _cancelBlock = [cancelBlock copy];
    }
}

- (void)cancel {
    self.cancelled = YES;
    if (self.cacheOperation)
    {
        [self.cacheOperation cancel];
        self.cacheOperation = nil;
    }
    if (self.cancelBlock) {
        self.cancelBlock();
        self.cancelBlock = nil;
    }
}

@end
