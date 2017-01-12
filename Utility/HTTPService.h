//
//  HTTPService.h
//  MockJSON
//
//  Created by caiyangjieto on 2017/1/12.
//  Copyright © 2017年 jiulvxing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HTTPService : NSObject

+ (void)startHTTPServer;
+ (void)stopHTTPServer;
+ (NSString *)getNativeIP;

@end
