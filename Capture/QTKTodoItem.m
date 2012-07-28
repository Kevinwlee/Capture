//
//  QTKTodoItem.m
//  Capture
//
//  Created by Kevin Lee on 7/25/12.
//  Copyright (c) 2012 Q Technology Company. All rights reserved.
//

#import "QTKTodoItem.h"

@implementation QTKTodoItem
@synthesize title = _title;


- (BOOL)isTodo {
    NSRange range = [self.title rangeOfString:@"t: "];
    if (range.length != 0) {
        return YES;
    }
    NSError *error = NULL;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"s: |f: |e: |i: |m: "
                                                                           options:NSRegularExpressionCaseInsensitive
                                                                             error:&error];
    
    NSInteger matches = [regex numberOfMatchesInString:self.title options:0 range:NSMakeRange(0, [self.title length])];

    return matches == 0;
}

- (NSString *)titleClean {

    NSString *text = self.title;
    NSError *error = NULL;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"t: |s: |f: |e: |i: |m: "
                                                                           options:NSRegularExpressionCaseInsensitive
                                                                             error:&error];
    
    NSString *modifiedString = [regex stringByReplacingMatchesInString:text
                                                               options:0
                                                                 range:NSMakeRange(0, [text length])
                                                          withTemplate:@""];
    return modifiedString;
}

@end
