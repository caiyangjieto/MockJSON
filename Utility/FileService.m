//
//  FileService.m
//  MockJSON
//
//  Created by caiyangjieto on 2017/1/12.
//  Copyright © 2017年 jiulvxing. All rights reserved.
//

#import "FileService.h"
#include <mach-o/dyld.h>

@implementation FileService


+ (NSString *)cacheJSONPath
{
    return [NSString stringWithFormat:@"%@/site", [FileService AppParentDirectory]];
}

+ (void)removeFileName:(NSString *)fileName
{
    NSString *strFullPath = [[FileService cacheJSONPath] stringByAppendingPathComponent:fileName];
    if([[NSFileManager defaultManager] fileExistsAtPath:strFullPath]){
        [[NSFileManager defaultManager] removeItemAtPath:strFullPath error:nil];
    }
}

+ (void)saveText:(NSString *)text toFile:(NSString *)fileName
{
    NSString *strRoot = [FileService cacheJSONPath];
    if(![[NSFileManager defaultManager] fileExistsAtPath:strRoot]){
        [[NSFileManager defaultManager] createDirectoryAtPath:strRoot withIntermediateDirectories:YES attributes:nil error:nil];
    }
    NSString *path = [strRoot stringByAppendingPathComponent:fileName];
    [text writeToFile:path atomically:YES encoding:NSUTF8StringEncoding error:nil];
}

+ (NSString *)readLocalFile:(NSString *)fileName
{
    NSString *path = [[FileService cacheJSONPath] stringByAppendingPathComponent:fileName];
    return [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    
}

#pragma mark - 

/**
 * 获取.app所在的目录。
 */
+ (NSString *) AppParentDirectory {
    NSString *pathExe = [self getExecutablePath];
    NSDictionary *dictInfo = [[NSBundle mainBundle] infoDictionary];
    NSString *strAppName = [NSString stringWithFormat:@"%@.app", [dictInfo objectForKey:@"CFBundleName"]];
    NSRange r = [pathExe rangeOfString:strAppName];
    return [pathExe substringToIndex:r.location - 1];
}

/**
 * 获取可执行的二进制文件的完整路径。
 */
+ (NSString *) getExecutablePath {
    char buf[0];
    uint32_t size = 0;
    _NSGetExecutablePath(buf,&size);
    
    char* path = (char*)malloc(size+1);
    path[size] = 0;
    _NSGetExecutablePath(path,&size);
    NSString *strPath = [NSString stringWithUTF8String:path];
    free(path);
    
    return strPath;
}

@end
