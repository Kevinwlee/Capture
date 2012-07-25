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
@end

@implementation QTKTodoService
@synthesize todoItems = _todoItems;

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
    return self;
}

- (NSArray *)allTodoItems{
    return self.todoItems;
}

- (NSArray *)todoItemsAtIndexes:(NSIndexSet *)indexes {
    return [self.todoItems objectsAtIndexes:indexes];
}

- (void)saveTodoItem:(QTKTodoItem *)item {
    [self.todoItems addObject:item];
    [[NSNotificationCenter defaultCenter] postNotificationName:kTodoItemAddedNotification object:item];
}

- (void)saveTodoItemWithQuickInputString:(NSString *)quickInput {
    QTKTodoItem *item = [[QTKTodoItem alloc] init];
    item.title = quickInput;
    [self saveTodoItem:item];
}
@end
