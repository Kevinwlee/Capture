//
//  QTKTodoService.h
//  Capture
//
//  Created by Kevin Lee on 7/25/12.
//  Copyright (c) 2012 Q Technology Company. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QTKTodoItem.h"

#define kTodoItemAddedNotification @"todoItemAddedNotification"
#define kTodoItemChangedNotification @"todoItemChangedNotification"
#define kLogItemAddedNotification @"logItemAddedNotification"

@interface QTKTodoService : NSObject
+ (QTKTodoService *)sharedService;
- (NSArray *)allTodoItems;
- (NSArray *)openTodoItems;
- (NSArray *)todoItemsAtIndexes:(NSIndexSet *)indexes;
- (void)saveTodoItem:(QTKTodoItem *)item;
- (void)saveTodoItemWithQuickInputString:(NSString *)quickInput;

- (NSArray *)allLogItems;

- (void)persistData;
@end
