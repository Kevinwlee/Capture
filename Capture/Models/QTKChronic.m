//
//  QTKChronic.m
//  Capture
//
//  Created by Lee, Kevin W. on 8/2/12.
//  Copyright (c) 2012 Q Technology Company. All rights reserved.
//

#import "QTKChronic.h"

@implementation QTKChronic
+ (NSDate*)parse:(NSString *)dayString {
    NSString *lowerCaseDayString = [dayString lowercaseString];
    NSCalendar* calendar = [NSCalendar currentCalendar];
    NSDate *today = [NSDate date];

    if ([lowerCaseDayString isEqualToString:@"today"]) {
        return today;
    }
    
    if ([lowerCaseDayString isEqualToString:@"tomorrow"]) {
        NSDateComponents* components = [[NSDateComponents alloc] init];
        [components setDay:1];
        NSDate *tomorrow = [calendar dateByAddingComponents:components toDate:today options:0];
        return tomorrow;
    }
    
    if ([lowerCaseDayString isEqualToString:@"monday"]) {
        unsigned int flags = NSWeekCalendarUnit | NSWeekdayCalendarUnit; 
        NSDateComponents *components = [calendar components:flags fromDate:today];
        int day = 2;
        int week = components.weekday < day?0:1;
        [components setWeekday:day];
        [components setWeek:[components week] + week];
        return [calendar dateFromComponents:components];
    }

    if ([lowerCaseDayString isEqualToString:@"tuesday"]) {
        unsigned int flags = NSWeekCalendarUnit | NSWeekdayCalendarUnit; 
        NSDateComponents *components = [calendar components:flags fromDate:today];
        int day = 3;
        int week = components.weekday < day?0:1;
        [components setWeekday:day];
        [components setWeek:[components week] + week];
        return [calendar dateFromComponents:components];
    }

    if ([lowerCaseDayString isEqualToString:@"wednesday"]) {
        unsigned int flags = NSWeekCalendarUnit | NSWeekdayCalendarUnit; 
        NSDateComponents *components = [calendar components:flags fromDate:today];
        int day = 4;
        int week = components.weekday < day?0:1;
        [components setWeekday:day];
        [components setWeek:[components week] + week];

        return [calendar dateFromComponents:components];
    }

    if ([lowerCaseDayString isEqualToString:@"thursday"]) {
        unsigned int flags = NSWeekCalendarUnit | NSWeekdayCalendarUnit; 
        NSDateComponents *components = [calendar components:flags fromDate:today];
        int day = 5;
        int week = components.weekday < day?0:1;
        [components setWeekday:day];
        [components setWeek:[components week] + week];

        return [calendar dateFromComponents:components];
    }

    if ([lowerCaseDayString isEqualToString:@"friday"]) {
        unsigned int flags = NSWeekCalendarUnit | NSWeekdayCalendarUnit; 
        NSDateComponents *components = [calendar components:flags fromDate:today];
        int day = 6;
        NSLog(@"day: %d", components.weekday);
        int week = components.weekday < day?0:1;
        [components setWeekday:day];
        [components setWeek:[components week] + week];
        return [calendar dateFromComponents:components];
    }

    if ([lowerCaseDayString isEqualToString:@"saturday"]) {
        unsigned int flags = NSWeekCalendarUnit | NSWeekdayCalendarUnit; 
        NSDateComponents *components = [calendar components:flags fromDate:today];
        int day = 7;
        int week = components.weekday < day?0:1;
        [components setWeekday:day];
        [components setWeek:[components week] + week];
        return [calendar dateFromComponents:components];
    }
    
    if ([lowerCaseDayString isEqualToString:@"sunday"]) {
        unsigned int flags = NSWeekCalendarUnit | NSWeekdayCalendarUnit; 
        NSDateComponents *components = [calendar components:flags fromDate:today];
        int day = 1;
        int week = components.weekday < day?0:1;
        [components setWeekday:day];
        [components setWeek:[components week] + week];
        return [calendar dateFromComponents:components];
    }

    return [NSDate date];    
}
@end
