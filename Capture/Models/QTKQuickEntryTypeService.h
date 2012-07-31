//
//  QTKEntryTypeService.h
//  Capture
//
//  Created by Lee, Kevin W. on 7/31/12.
//  Copyright (c) 2012 Q Technology Company. All rights reserved.
//

#import <Foundation/Foundation.h>
enum {
    QTKQuickEntryTags = 0,
    QTKQuickEntryDurations = 1,
    QTKQuickEntryDueDates = 2,
    QTKQuickEntryProjects = 3,
    QTKQuickEntryPeople = 4,
    QTKQuickEntryEvents = 5
};
typedef NSUInteger QTKQuickEntryType;


@interface QTKQuickEntryTypeService : NSObject
+ (QTKQuickEntryTypeService*)sharedService;
- (NSArray *)quickEntryItemsFor:(QTKQuickEntryType)type;
@end
