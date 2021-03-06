//
//  QTKTodoItem.h
//  Capture
//
//  Created by Kevin Lee on 7/25/12.
//  Copyright (c) 2012 Q Technology Company. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QTKTodoItem : NSObject <NSCoding>
@property (nonatomic, strong) NSString *quickEntryText;
@property (nonatomic, strong) NSDate *createdAt;
@property (nonatomic, strong) NSDate *updatedAt;
@property (nonatomic, strong) NSDate *completedOn;
@property (nonatomic) BOOL completed;
@property (nonatomic, readonly) NSDate *completedOnDate;
@property (nonatomic, readonly) NSString *text;
@property (nonatomic, strong) NSDate *dueDate;

- (id)initWithQuickEntryText:(NSString *)quickEntryText;
- (BOOL)isTodo;
@end
