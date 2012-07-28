//
//  QTKTagTableViewController.h
//  Capture
//
//  Created by Kevin Lee on 7/27/12.
//  Copyright (c) 2012 Q Technology Company. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol QTKTagListDelegate <NSObject>
- (void)didSelectTag:(NSString *)tag;
@end

@interface QTKTagTableViewController : UITableViewController
@property (nonatomic, strong) id<QTKTagListDelegate> delegate;
@end
