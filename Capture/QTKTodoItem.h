//
//  QTKTodoItem.h
//  Capture
//
//  Created by Kevin Lee on 7/25/12.
//  Copyright (c) 2012 Q Technology Company. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QTKTodoItem : NSObject
@property (nonatomic, strong) NSString *title;
@property (nonatomic, readonly) NSString *titleClean;

- (BOOL)isTodo;

@end
