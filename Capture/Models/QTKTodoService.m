//
//  QTKTodoService.m
//  Capture
//
//  Created by Kevin Lee on 7/25/12.
//  Copyright (c) 2012 Q Technology Company. All rights reserved.
//

#import "QTKTodoService.h"
#import "QTKPathHelpers.h"

@interface QTKTodoService()
@property (nonatomic, strong) NSMutableArray *todoItems;
@property (nonatomic, strong) NSMutableArray *logItems;
- (void)persistActionItems;
- (void)persistLogItems;
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
    
    NSString *path = PathForFileInDocumentsDirectory(@"ActionItems.db");
    self.todoItems = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
  
    path = PathForFileInDocumentsDirectory(@"Log.db");
    self.logItems = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(persistActionItems) name:kTodoItemChangedNotification object:nil];
    return self;
}

- (NSArray *)allTodoItems {
    return self.todoItems;
}

- (NSArray *)openTodoItems {
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"completed == NO"];
    NSArray *openItems = [self.todoItems filteredArrayUsingPredicate:pred];
    return openItems;
}

- (NSArray *)todoItemsAtIndexes:(NSIndexSet *)indexes {
    return [self.todoItems objectsAtIndexes:indexes];
}

- (void)saveTodoItem:(QTKTodoItem *)item {
    if ([item isTodo]) {
        [self.todoItems addObject:item];
        item.createdAt = [NSDate date];
        item.completed = NO;
        [[NSNotificationCenter defaultCenter] postNotificationName:kTodoItemAddedNotification object:item];
        [self persistActionItems];
    } else {
        [self.logItems addObject:item];
        item.createdAt = [NSDate date];
        item.completed = NO;
        item.completedOn =  [NSDate date];
        [[NSNotificationCenter defaultCenter] postNotificationName:kLogItemAddedNotification object:item];        
        [self persistLogItems];
    }
}
- (void)completeTodoItem:(QTKTodoItem *)item{
    if ([self.todoItems containsObject:item]){
        NSLog(@"I'm already here, just mark me as completed and be done with it");
    } else {
        NSLog(@"Hm , you'll need to find it and complete it and save it");
    }
}

- (void)saveTodoItemWithQuickInputString:(NSString *)quickInput {
    QTKTodoItem *item = [[QTKTodoItem alloc] init];
    item.title = quickInput;
    [self saveTodoItem:item];
}


- (NSArray *)allLogItems{
    return self.logItems;
}

- (void)persistActionItems {
    dispatch_async(dispatch_queue_create("qteko.async.action.queue", nil), ^{
        NSString *path = PathForFileInDocumentsDirectory(@"ActionItems.db");
        BOOL OK = [NSKeyedArchiver archiveRootObject:self.todoItems toFile:path];        
        if (!OK) {
            NSLog(@"Couldn't save the ActionItems");
        }
    });
}

- (void)persistLogItems {
    dispatch_async(dispatch_queue_create("qteko.async.log.queue", nil), ^{
        NSString *path = PathForFileInDocumentsDirectory(@"Log.db");
        BOOL OK = [NSKeyedArchiver archiveRootObject:self.logItems toFile:path];
        if (!OK) {
            NSLog(@"Couldn't save the log.");
        }
    });
}

- (void)persistData {
    [self persistActionItems];
    [self persistLogItems];
}
@end
