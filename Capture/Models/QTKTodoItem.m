//
//  QTKTodoItem.m
//  Capture
//
//  Created by Kevin Lee on 7/25/12.
//  Copyright (c) 2012 Q Technology Company. All rights reserved.
//

#import "QTKTodoItem.h"
#import "QTKChronic.h"

@interface QTKTodoItem()
@property (nonatomic, readonly) NSString *quickEntryTextStrippedOfAction;
@end

@implementation QTKTodoItem
@synthesize quickEntryText = _title;
@synthesize createdAt = _createdAt, updatedAt = _updatedAt, completedOn = _completedOn;
@synthesize completed;
@synthesize dueDate;

- (id)initWithQuickEntryText:(NSString *)quickEntryText {
    self = [super init];
    if (self) {
        self.quickEntryText = quickEntryText;
        self.createdAt = [NSDate date];
        self.updatedAt = [NSDate date];
        
        if (!self.isTodo) {
            self.completedOn = [NSDate date];
            self.completed = YES;
        }
    }
    return self;
}

- (BOOL)isTodo {
    NSRange range = [self.quickEntryText rangeOfString:@"t: "];
    if (range.length != 0) {
        return YES;
    }
    NSError *error = NULL;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"s: |f: |e: |i: |m: "
                                                                           options:NSRegularExpressionCaseInsensitive
                                                                             error:&error];
    
    NSInteger matches = [regex numberOfMatchesInString:self.quickEntryText options:0 range:NSMakeRange(0, [self.quickEntryText length])];

    return matches == 0;
}

- (NSString *)quickEntryTextStrippedOfAction {

    NSString *text = self.quickEntryText;
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

- (BOOL)due {
    unsigned int flags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit;
    NSCalendar* calendar = [NSCalendar currentCalendar];
    NSDateComponents* components = [calendar components:flags fromDate:self.createdAt];
    NSDate *created = [calendar dateFromComponents:components];
    
    components = [calendar components:flags fromDate:[NSDate date]];
    NSDate *today = [calendar dateFromComponents:components];
    return [today isEqualToDate:created];                  
}

- (void)setPropertiesFromQuickString {
    NSString *escapedRegex = @"\\^[a-zA-Z]*";
    
    
    NSRegularExpression *expression = [NSRegularExpression 
                                       regularExpressionWithPattern:escapedRegex 
                                       options:0 
                                       error:nil];
    
    [expression enumerateMatchesInString:self.quickEntryText
                                 options:0
                                   range:NSMakeRange(0, self.quickEntryText.length) 
                              usingBlock:^(NSTextCheckingResult *result, NSMatchingFlags flags, BOOL *stop) {
                                  NSRange range = result.range;
                                  range.location ++;
                                  range.length --;
                                  NSString *matchString = [self.quickEntryText substringWithRange:range];
                                  NSLog(@"%@", [QTKChronic parse:matchString]);
                              }];
}

- (NSString*)text {
    [self setPropertiesFromQuickString];
    NSString *textToBe = self.quickEntryTextStrippedOfAction;
    NSArray *components = [textToBe componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"#^=~@$"]];
    return [components objectAtIndex:0];
}

#pragma mark - NSCoding

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.quickEntryText forKey:@"title"];
    [aCoder encodeObject:self.createdAt forKey:@"createdAt"];
    [aCoder encodeObject:self.updatedAt forKey:@"updatedAt"];
    [aCoder encodeObject:self.completedOn forKey:@"completedOn"];
    [aCoder encodeObject:self.dueDate forKey:@"dueDate"];
    [aCoder encodeObject:[NSNumber numberWithBool:self.completed] forKey:@"completed"];
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (self) {
        self.quickEntryText = [aDecoder decodeObjectForKey:@"title"];
        self.createdAt = [aDecoder decodeObjectForKey:@"createdAt"];
        self.updatedAt = [aDecoder decodeObjectForKey:@"updatedAt"];
        self.completedOn = [aDecoder decodeObjectForKey:@"completedOn"];
        self.completed = [[aDecoder decodeObjectForKey:@"completed"] boolValue];
        self.dueDate = [aDecoder decodeObjectForKey:@"dueDate"];
    }
    return self;
}


@end
