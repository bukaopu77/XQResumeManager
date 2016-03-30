//
//  XQResumeManager.h
//  XQResumeManager
//
//  Created by 周剑 on 16/3/30.
//  Copyright © 2016年 bukaopu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XQResumeManager : NSObject


// url 资源路径
// targetPath 存放路径
// success 成功回调的block
// failure 失败回调的block
// progress 进度的block
+ (XQResumeManager *)resumeManagerWithURL:(NSURL*)url
                              targetPath:(NSString*)targetPath
                                 success:(void (^)())success
                                 failure:(void (^)(NSError *error))failure
                                progress:(void (^)(long long totalReceivedContentLength, long long totalContentLength))progress;

// 开始
- (void)start;

// 取消
- (void)cancel;

@end
