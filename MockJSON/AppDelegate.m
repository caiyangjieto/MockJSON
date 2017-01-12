//
//  AppDelegate.m
//  MockJSON
//
//  Created by caiyangjieto on 15/9/1.
//  Copyright (c) 2017年 jiulvxing. All rights reserved.
//

#import "AppDelegate.h"
#import "HTTPService.h"
#import "FileService.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
    [HTTPService startHTTPServer];
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}

- (BOOL)applicationShouldTerminateAfterLastWindowClosed:(NSApplication *)sender{
    [HTTPService stopHTTPServer];
    return YES;
}

#pragma mark - 工具
/**
 * 菜单项：File - Open Site Root
 */
- (IBAction)openSiteRoot:(id)sender
{
    NSString *strRoot = [FileService cacheJSONPath];
    if(![[NSFileManager defaultManager] fileExistsAtPath:strRoot]){
        [[NSFileManager defaultManager] createDirectoryAtPath:strRoot withIntermediateDirectories:YES attributes:nil error:nil];
    }
    NSString *strShell = [NSString stringWithFormat:@"open %@", strRoot];
    const char * copyShellChar =[strShell UTF8String];
    system(copyShellChar);
}

@end
