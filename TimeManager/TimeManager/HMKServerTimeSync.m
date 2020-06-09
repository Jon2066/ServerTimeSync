//
//  HMKServerTimeSync.m
//  TimeManager
//
//  Created by Jonathan on 2020/6/9.
//  Copyright © 2020 IMK. All rights reserved.
//

#import "HMKServerTimeSync.h"
#include <sys/sysctl.h>

@interface HMKServerTimeSync ()

@property (nonatomic, assign) NSTimeInterval localTimeSpace;

@end

@implementation HMKServerTimeSync

+ (instancetype)sharedInstance
{
    static HMKServerTimeSync *hmk_serverTime_sync = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        hmk_serverTime_sync = [[HMKServerTimeSync alloc] init];
    });
    return hmk_serverTime_sync;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _localTimeSpace = 0;
    }
    return self;
}

- (void)setCurrentServerTime:(NSTimeInterval)serverTime
{
    NSTimeInterval local = [self deviceBootTime];
    self.localTimeSpace = serverTime - local;
}

- (NSTimeInterval)currentTime
{
    return self.localTimeSpace + [self deviceBootTime];
}

- (time_t)deviceBootTime
{
    struct timeval boottime;
    int mib[2] = {CTL_KERN, KERN_BOOTTIME};
    size_t size = sizeof(boottime);
    time_t now;
    time_t uptime = -1;

    (void)time(&now);

    if (sysctl(mib, 2, &boottime, &size, NULL, 0) != -1 && boottime.tv_sec != 0) {
        uptime = now - boottime.tv_sec;
    }

    return uptime;
}
@end
