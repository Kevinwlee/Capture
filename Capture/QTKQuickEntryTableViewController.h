//
//  QTKQuickEntryTableViewController.h
//  Capture
//
//  Created by Kevin Lee on 7/27/12.
//  Copyright (c) 2012 Q Technology Company. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QTKQuickEntryTypeService.h"

@protocol QTKQuickEntryDelegate <NSObject>
- (void)didSelectEntry:(NSString *)entry;
@end

@interface QTKQuickEntryTableViewController : UITableViewController
@property (nonatomic, strong) NSArray *items;
@property (nonatomic, strong) id<QTKQuickEntryDelegate> delegate;

- (id)initWithStyle:(UITableViewStyle)style forQuickEntryItem:(QTKQuickEntryType)quickEntryType;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil quickEntryType: (QTKQuickEntryType)quickEntryType;
@end
