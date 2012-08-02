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

- (NSArray *)todaysTodoItems {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"due == YES"];    
    NSArray *due = [[self openTodoItems] filteredArrayUsingPredicate:predicate];
    return due;
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
        [[NSNotificationCenter defaultCenter] postNotificationName:kTodoItemAddedNotification object:item];
        [self persistActionItems];
    } else {
        [self.logItems addObject:item];
        [[NSNotificationCenter defaultCenter] postNotificationName:kLogItemAddedNotification object:item];        
        [self persistLogItems];
    }
}

- (void)saveTodoItemWithQuickInputString:(NSString *)quickInput {
    QTKTodoItem *item = [[QTKTodoItem alloc] initWithQuickEntryText:quickInput];
    [self saveTodoItem:item];
}

- (NSArray *)allLogItems{
    return self.logItems;
}

- (NSArray *)allLogItemsGroupedByDay {


    NSArray *dates = [self.logItems valueForKeyPath:@"@distinctUnionOfObjects.completedOnDate"];
    NSSortDescriptor* sortDatesDescriptor = [NSSortDescriptor sortDescriptorWithKey:nil ascending:NO selector:@selector(compare:)];
    NSArray *sortedLog =  [dates sortedArrayUsingDescriptors:[NSArray arrayWithObject:sortDatesDescriptor]];
    NSMutableArray *datasource = [NSMutableArray array];
    for (NSDate *date in sortedLog) {
        NSLog(@"Date %@", date);
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"completedOnDate == %@", date];
        NSArray *filteredArray = [self.logItems filteredArrayUsingPredicate:predicate];
        [datasource addObject:filteredArray];
    }
    return datasource;
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
