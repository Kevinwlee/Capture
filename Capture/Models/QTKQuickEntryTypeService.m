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
            
        default:
            break;
    }
    return itemsArray;
}
@end
