//
//  FileService.h
//  MockJSON
//
//  Created by caiyangjieto on 2017/1/12.
//  Copyright © 2017年 jiulvxing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FileService : NSObject

+ (NSString *)cacheJSONPath;
+ (void)removeFileName:(NSString *)fileName;
+ (void)saveText:(NSString *)text toFile:(NSString *)fileName;
+ (NSString *)readLocalFile:(NSString *)fileName;

@end
