//
//  HTTPService.m
//  MockJSON
//
//  Created by caiyangjieto on 2017/1/12.
//  Copyright © 2017年 jiulvxing. All rights reserved.
//

#import "HTTPService.h"
#import "HTTPServer.h"
#import "DDLog.h"
#import "DDTTYLogger.h"
#import "FileService.h"

#include <ifaddrs.h>
#include <unistd.h>
#include <netdb.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <arpa/inet.h>

static const int ddLogLevel = LOG_LEVEL_VERBOSE;


@interface HTTPService ()

@property (nonatomic, strong) HTTPServer *httpServer;
@end


@implementation HTTPService

+ (HTTPService *)getInstance
{
    static HTTPService *httpService = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        httpService = [[super allocWithZone:NULL] init];
        
    });
    
    return httpService;
}

+ (id)allocWithZone:(NSZone *)zone
{
    return [self getInstance];
}

- (id)copyWithZone:(NSZone *)zone
{
    return self;
}

#pragma mark - 服务

+ (void)startHTTPServer
{
    if([[self getInstance].httpServer isRunning]){
        return;
    }
    
    // Configure our logging framework.
    // To keep things simple and fast, we're just going to log to the Xcode console.
    [DDLog addLogger:[DDTTYLogger sharedInstance]];
    
    // Initalize our http server
    [self getInstance].httpServer = [[HTTPServer alloc] init];
    [[self getInstance].httpServer setType:@"_http._tcp."];
    [[self getInstance].httpServer setPort:8080];
    
    NSString *strSiteRoot = [FileService cacheJSONPath];
    DDLogInfo(@"Setting document root: %@", strSiteRoot);
    [[self getInstance].httpServer setDocumentRoot:strSiteRoot];
    NSError *error = nil;
    if(![[self getInstance].httpServer start:&error])
    {
        DDLogError(@"Error starting HTTP Server: %@", error);
    }
}

+ (void)stopHTTPServer
{
    if([[self getInstance].httpServer isRunning])
    {
        [[self getInstance].httpServer stop];
    }
}

#pragma mark - 获取IP地址
+ (NSString *)getNativeIP
{
    char hname[128];
    struct hostent *hent;
    
    gethostname(hname, sizeof(hname));
    hent = gethostbyname(hname);
    
    char* ip = inet_ntoa(*(struct in_addr*)(hent->h_addr_list[0]));
    return [NSString stringWithUTF8String:ip];
}

@end
