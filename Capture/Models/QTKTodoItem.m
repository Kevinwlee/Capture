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
@synthesize createdAt = _createdAt, updatedAt = _updatedAt, completedOn = _completedOn;
@synthesize completed;

- (id)initLogItemWithTitle:(NSString*)title {
    self = [super init];
    if (self) {
        self.title = title;
        self.createdAt = [NSDate date];
        self.updatedAt = [NSDate date];
        self.completedOn = [NSDate date];
        self.completed = YES;
    }
    return self;
}
- (id)initTodoItemWithTitle:(NSString*)title {
    self = [super init];
    if (self) {
        self.title = title;
        self.createdAt = [NSDate date];
        self.completed = NO;
    }
    return self;
}

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


- (NSDate *)completedOnDate {
    unsigned int flags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit;
    NSCalendar* calendar = [NSCalendar currentCalendar];
    NSDateComponents* components = [calendar components:flags fromDate:self.completedOn];
    return [calendar dateFromComponents:components];
}


#pragma mark - NSCoding

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.title forKey:@"title"];
    [aCoder encodeObject:self.createdAt forKey:@"createdAt"];
    [aCoder encodeObject:self.updatedAt forKey:@"updatedAt"];
    [aCoder encodeObject:self.completedOn forKey:@"completedOn"];
    [aCoder encodeObject:[NSNumber numberWithBool:self.completed] forKey:@"completed"];
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (self) {
        self.title = [aDecoder decodeObjectForKey:@"title"];
        self.createdAt = [aDecoder decodeObjectForKey:@"createdAt"];
        self.updatedAt = [aDecoder decodeObjectForKey:@"updatedAt"];
        self.completedOn = [aDecoder decodeObjectForKey:@"completedOn"];
        self.completed = [[aDecoder decodeObjectForKey:@"completed"] boolValue];
    }
    return self;
}

@end
