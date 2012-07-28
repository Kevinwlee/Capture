//
//  QTKToDoTableViewController.h
//  Capture
//
//  Created by Kevin Lee on 7/24/12.
//  Copyright (c) 2012 Q Technology Company. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QTKTodoService.h"

@protocol QTKTodoListDelegate <NSObject>
- (void)didSelecteTodoItem:(QTKTodoItem*)item;
@end

@interface QTKToDoTableViewController : UITableViewController
@property (nonatomic, strong) NSMutableArray *items;
@property (nonatomic, strong) id<QTKTodoListDelegate> delegate;
@end
