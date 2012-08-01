//
//  QTKEntryTypeService.m
//  Capture
//
//  Created by Lee, Kevin W. on 7/31/12.
//  Copyright (c) 2012 Q Technology Company. All rights reserved.
//

#import "QTKQuickEntryTypeService.h"

@implementation QTKQuickEntryTypeService
+ (QTKQuickEntryTypeService*)sharedService {
    static QTKQuickEntryTypeService *_sharedService =nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedService = [QTKQuickEntryTypeService new];
    });
    return _sharedService;
}

- (id)init {
    self = [super init];
    if (!self) {
        return nil;
    }
    return self;
}

- (NSArray *)quickEntryItemsFor:(QTKQuickEntryType)type {
    NSArray *itemsArray = nil;
    switch (type) {
        case QTKQuickEntryTags:
            itemsArray = [NSArray arrayWithObjects:@"#note", @"idea", @"#work",@"#chatting",@"#email",@"#adhoc meeting",@"#", nil];
            break;
        case QTKQuickEntryDueDates:
            itemsArray = [NSArray arrayWithObjects:@"^today", @"^tomorrow", @"^sunday", @"^monday", @"^tuesday", @"^wednesday", @"^thursday", @"^friday", @"^saturday", @"sunday",nil];
            break;
        case QTKQuickEntryDurations:
            itemsArray = [NSArray arrayWithObjects:@"=15min",@"=30min",@"=45min",@"=1h",@"=1.5h", @"=", nil];
            break;
        case QTKQuickEntryPeople:
            itemsArray = [NSArray arrayWithObjects:@"~Jian", @"~Kelsey", @"~Mark", @"~Joie", @"Anauradha~", nil];
            break;
        case QTKQuickEntryProjects:
            itemsArray = [NSArray arrayWithObjects:@"$Invesco Mobile", @"$Docket", @"$TO", @"$University Laundry", nil];
            break;
        case QTKQuickEntryEvents:
            itemsArray = [NSArray arrayWithObjects:@"@Stand Up",@"@Tech Review", @"@", nil];
            break;
        case QTKQuickEntryActions:
            itemsArray = [NSArray arrayWithObjects:@"add ", @"call ", @"create ",@"email ", @"finalize ", @"pickup ", @"research ", @"send ", nil];
            break;
        default:
            itemsArray = [NSArray array];
            break;
    }
    return itemsArray;
}
@end
