//
//  NSString+Utility.h
//  MockJSON
//
//  Created by test on 15/12/26.
//  Copyright © 2017年 jiulvxing. All rights reserved.
//

#import <Foundation/Foundation.h>

//block中self
#define WeakObj(o)                      autoreleasepool{} __weak __typeof(o) o##Weak = o;
#define StrongObj(o)                    autoreleasepool{} __strong __typeof(o##Weak) o##Strong = o##Weak;

@interface NSString(Utility)

- (BOOL) jsonValidate;

@end
