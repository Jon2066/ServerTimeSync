//
//  HMKServerTimeSync.h
//  TimeManager
//
//  Created by Jonathan on 2020/6/9.
//  Copyright © 2020 IMK. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HMKServerTimeSync : NSObject

+ (instancetype)sharedInstance;

/// 设置当前服务时间
- (void)setCurrentServerTime:(NSTimeInterval)serverTime;

/// 获取当前服务器时间  先设置setCurrentServerTime
- (NSTimeInterval)currentTime;

@end

NS_ASSUME_NONNULL_END
