//
//  QTKViewController.h
//  Capture
//
//  Created by Kevin Lee on 7/24/12.
//  Copyright (c) 2012 Q Technology Company. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QTKDurationTableViewController.h"
#import "QTKLogTableViewController.h"
#import "QTKToDoTableViewController.h"
#import "QTKTodoService.h"

@interface QTKViewController : UIViewController
@property (strong, nonatomic) IBOutlet QTKDurationTableViewController *durationTableViewController;
@property (weak, nonatomic) IBOutlet UIView *quickEntryView;
@property (strong, nonatomic) IBOutlet QTKLogTableViewController *logTableViewController;
@property (strong, nonatomic) IBOutlet QTKToDoTableViewController *todoTableViewController;
@property (weak, nonatomic) IBOutlet UITextField *inputTextField;
@property (weak, nonatomic) IBOutlet UIView *todoView;

- (IBAction)doneTapped:(id)sender;
- (IBAction)okayTapped:(id)sender;

@end
