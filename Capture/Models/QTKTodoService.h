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

@interface QTKTodoService : NSObject
+ (QTKTodoService *)sharedService;
- (NSArray *)allTodoItems;
- (NSArray *)todoItemsAtIndexes:(NSIndexSet *)indexes;
- (void)saveTodoItem:(QTKTodoItem *)item;
- (void)saveTodoItemWithQuickInputString:(NSString *)quickInput;
@end
