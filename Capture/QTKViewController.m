//
//  QTKViewController.m
//  Capture
//
//  Created by Kevin Lee on 7/24/12.
//  Copyright (c) 2012 Q Technology Company. All rights reserved.
//

#import "QTKViewController.h"

@interface QTKViewController ()

@end

@implementation QTKViewController
@synthesize logTableViewController;
@synthesize todoTableViewController;
@synthesize inputTextField;
@synthesize todoView;
@synthesize quickEntryView;
@synthesize durationTableViewController;

- (void)viewDidLoad
{
    [super viewDidLoad];
    CGRect frame = self.quickEntryView.frame;
    frame.size.height = 0;
    self.quickEntryView.frame = frame;
    [self addChildViewController:self.todoTableViewController];
    [self addChildViewController:self.logTableViewController];
    [self.todoView addSubview:self.todoTableViewController.view];
    self.todoTableViewController.view.frame = self.todoView.bounds;
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [self setDurationTableViewController:nil];
    [self setQuickEntryView:nil];
    [self setLogTableViewController:nil];
    [self setTodoTableViewController:nil];
    [self setInputTextField:nil];
    [self setTodoView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

- (IBAction)doneTapped:(id)sender {    
    
    [UIView animateWithDuration:.2 animations:^{
        CGRect frame = self.quickEntryView.frame;
        frame.size.height = 63;
        self.quickEntryView.frame = frame;
    }];
}

- (IBAction)okayTapped:(id)sender {
    [self.inputTextField resignFirstResponder];
    [UIView animateWithDuration:.2 animations:^{
        CGRect frame = self.quickEntryView.frame;
        frame.size.height = 0;
        self.quickEntryView.frame = frame;
    }];

    QTKTodoService *svc = [QTKTodoService sharedService];
    [svc saveTodoItemWithQuickInputString:self.inputTextField.text];
    self.inputTextField.text = @"";    
}

@end
