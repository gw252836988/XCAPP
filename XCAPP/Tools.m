//
//  Tools.m
//  XCAPP
//
//  Created by 新城集团 on 16-9-30.
//  Copyright (c) 2016年 新城集团. All rights reserved.
//

#import "Tools.h"

@implementation Tools

+ (BOOL) isBlankString:(NSString *)string {
    if (string == nil || string == NULL) {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return YES;
    }
    return NO;
}
@end
