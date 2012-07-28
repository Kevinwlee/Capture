//
//  QTKDurationTableViewController.h
//  Capture
//
//  Created by Kevin Lee on 7/24/12.
//  Copyright (c) 2012 Q Technology Company. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol QTKDurationListDelegate <NSObject>

- (void)didSelectDuration:(NSString *)duration;

@end

@interface QTKDurationTableViewController : UITableViewController
@property (nonatomic, strong) id<QTKDurationListDelegate> delegate;
@end
