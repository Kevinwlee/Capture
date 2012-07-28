//
//  QTKTodoService.m
//  Capture
//
//  Created by Kevin Lee on 7/25/12.
//  Copyright (c) 2012 Q Technology Company. All rights reserved.
//

#import "QTKTodoService.h"

@interface QTKTodoService()
@property (nonatomic, strong) NSMutableArray *todoItems;
@property (nonatomic, strong) NSMutableArray *logItems;
@end

@implementation QTKTodoService
@synthesize todoItems = _todoItems;
@synthesize logItems = _logItems;

+ (QTKTodoService *)sharedService {
    static QTKTodoService * _sharedService = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedService = [QTKTodoService new];
    });
    return _sharedService;
}

- (id)init {
    self = [super init];
    if (!self) {
        return nil;
    }
    _todoItems = [NSMutableArray array];
    _logItems = [NSMutableArray array];
    return self;
}

- (NSArray *)allTodoItems{
    return self.todoItems;
}

- (NSArray *)todoItemsAtIndexes:(NSIndexSet *)indexes {
    return [self.todoItems objectsAtIndexes:indexes];
}

- (void)saveTodoItem:(QTKTodoItem *)item {
    if ([item isTodo]) {
        [self.todoItems addObject:item];
        [[NSNotificationCenter defaultCenter] postNotificationName:kTodoItemAddedNotification object:item];
    } else {
        [self.logItems addObject:item];
        [[NSNotificationCenter defaultCenter] postNotificationName:kLogItemAddedNotification object:item];        
    }
}

- (void)saveTodoItemWithQuickInputString:(NSString *)quickInput {
    QTKTodoItem *item = [[QTKTodoItem alloc] init];
    item.title = quickInput;
    [self saveTodoItem:item];
}

- (NSArray *)allLogItems{
    return self.todoItems;
}

@end
