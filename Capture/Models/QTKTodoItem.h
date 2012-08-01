//
//  QTKTodoItem.h
//  Capture
//
//  Created by Kevin Lee on 7/25/12.
//  Copyright (c) 2012 Q Technology Company. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QTKTodoItem : NSObject <NSCoding>
@property (nonatomic, strong) NSString *title;
@property (nonatomic, readonly) NSString *titleClean;
@property (nonatomic, strong) NSDate *createdAt;
@property (nonatomic, strong) NSDate *updatedAt;
@property (nonatomic, strong) NSDate *completedOn;
@property (nonatomic) BOOL completed;
@property (nonatomic, readonly) NSDate *completedOnDate;

- (id)initLogItemWithTitle:(NSString*)title;
- (id)initTodoItemWithTitle:(NSString*)title;
- (BOOL)isTodo;
@end
