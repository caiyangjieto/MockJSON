//
//  NSString+Utility.m
//  MockJSON
//
//  Created by test on 15/12/26.
//  Copyright © 2017年 jiulvxing. All rights reserved.
//

#import "NSString+Utility.h"

@implementation NSString(Utility)

/**
 * OUT  :YES->合法；NO->不合法
 */
- (BOOL) jsonValidate
{
    return [NSJSONSerialization JSONObjectWithData:[self dataUsingEncoding:NSUTF8StringEncoding]
                                           options:NSJSONReadingMutableLeaves
                                             error:nil] != nil;
}
@end
