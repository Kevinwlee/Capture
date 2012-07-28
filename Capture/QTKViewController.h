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

@interface QTKViewController : UIViewController <UITextFieldDelegate, QTKTodoListDelegate, QTKDurationListDelegate>
@property (strong, nonatomic) IBOutlet QTKDurationTableViewController *durationTableViewController;
@property (weak, nonatomic) IBOutlet UIView *quickEntryView;
@property (strong, nonatomic) IBOutlet QTKLogTableViewController *logTableViewController;
@property (strong, nonatomic) IBOutlet QTKToDoTableViewController *todoTableViewController;
@property (weak, nonatomic) IBOutlet UITextField *inputTextField;
@property (weak, nonatomic) IBOutlet UIView *todoView;
@property (weak, nonatomic) IBOutlet UIButton *todoButton;
@property (weak, nonatomic) IBOutlet UIButton *finishedButton;
@property (weak, nonatomic) IBOutlet UIButton *startButton;
@property (weak, nonatomic) IBOutlet UIButton *meetingButton;
@property (weak, nonatomic) IBOutlet UIButton *webButton;
@property (weak, nonatomic) IBOutlet UIButton *externalButton;
@property (weak, nonatomic) IBOutlet UIButton *durationButton;
@property (weak, nonatomic) IBOutlet UIView *logView;

- (IBAction)doneTapped:(id)sender;
- (IBAction)okayTapped:(id)sender;
- (IBAction)todoTapped:(id)sender;
- (IBAction)finishedTapped:(id)sender;
- (IBAction)startTapped:(id)sender;
- (IBAction)meetingTapped:(id)sender;
- (IBAction)webTapped:(id)sender;
- (IBAction)walkinTapped:(id)sender;

- (IBAction)durationTapped:(id)sender;
@end
