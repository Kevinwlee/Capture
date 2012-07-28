//
//  QTKViewController.m
//  Capture
//
//  Created by Kevin Lee on 7/24/12.
//  Copyright (c) 2012 Q Technology Company. All rights reserved.
//

#import "QTKViewController.h"

@interface QTKViewController ()<UIPopoverControllerDelegate>
@property(nonatomic, strong) UIPopoverController *popoverController;
@property (nonatomic, strong) NSMutableArray *buttons;
- (NSString *)cleanString;
- (void)showQuickBar;
- (void)hideQuickBar;
- (void)deselectButtons;
- (void)handleHUDTapForButton:(UIButton*)button andActionString:(NSString *)actionString;
@end

@implementation QTKViewController
@synthesize logTableViewController;
@synthesize todoTableViewController;
@synthesize inputTextField;
@synthesize todoView;
@synthesize todoButton;
@synthesize finishedButton;
@synthesize startButton;
@synthesize meetingButton;
@synthesize webButton;
@synthesize externalButton;
@synthesize durationButton;
@synthesize logView;
@synthesize quickEntryView;
@synthesize durationTableViewController;
@synthesize popoverController;
@synthesize buttons;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    CGRect frame = self.quickEntryView.frame;
    frame.size.height = 0;
    self.quickEntryView.frame = frame;

    [self addChildViewController:self.todoTableViewController];
    [self.todoView addSubview:self.todoTableViewController.view];
    self.todoTableViewController.view.frame = self.todoView.bounds;
    self.todoTableViewController.delegate = self;

    [self addChildViewController:self.logTableViewController];    
    [self.logView addSubview:self.logTableViewController.view];
    self.logTableViewController.view.frame = self.logView.bounds;
    
    self.buttons = [NSArray arrayWithObjects:self.todoButton, self.finishedButton, self.startButton,
                    self.meetingButton, self.webButton, self.externalButton, nil];
    
    self.durationTableViewController.delegate = self;
}

- (void)viewDidUnload
{
    [self setDurationTableViewController:nil];
    [self setQuickEntryView:nil];
    [self setLogTableViewController:nil];
    [self setTodoTableViewController:nil];
    [self setInputTextField:nil];
    [self setTodoView:nil];
    [self setTodoButton:nil];
    [self setFinishedButton:nil];
    [self setStartButton:nil];
    [self setMeetingButton:nil];
    [self setWebButton:nil];
    [self setExternalButton:nil];
    [self setDurationButton:nil];
    [self setLogView:nil];
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
    
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.inputTextField resignFirstResponder];
}

- (NSString *)cleanString {
    NSString *text = self.inputTextField.text;
    NSError *error = NULL;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"t: |s: |f: |e: |i: |m: "
                                                                           options:NSRegularExpressionCaseInsensitive
                                                                             error:&error];
    
    NSString *modifiedString = [regex stringByReplacingMatchesInString:text
                                                               options:0
                                                                 range:NSMakeRange(0, [text length])
                                                          withTemplate:@""];
    return modifiedString;
}

- (void)showQuickBar {
    [UIView animateWithDuration:.2 animations:^{
        CGRect frame = self.quickEntryView.frame;
        frame.size.height = 63;
        self.quickEntryView.frame = frame;
    }];
}

- (void)hideQuickBar {
    [UIView animateWithDuration:.2 animations:^{
        CGRect frame = self.quickEntryView.frame;
        frame.size.height = 0;
        self.quickEntryView.frame = frame;
    }];
}

- (void)deselectButtons {
    for (UIButton *button in self.buttons) {
        button.selected = NO;
    }
}

- (void)handleHUDTapForButton:(UIButton*)button andActionString:(NSString *)actionString {
    if (button.selected) {
        self.inputTextField.text = [self cleanString];
        [self deselectButtons];
    } else {
        [self deselectButtons];
        button.selected = YES;
        [self showQuickBar];
        NSMutableString *cleanString = [NSMutableString stringWithString:[self cleanString]];
        [cleanString insertString:actionString atIndex:0];
        self.inputTextField.text = cleanString;
    }
         
}


#pragma mark - quick entry actions

- (IBAction)okayTapped:(id)sender {
    [self.inputTextField resignFirstResponder];
    [self hideQuickBar];
    QTKTodoService *svc = [QTKTodoService sharedService];
    [svc saveTodoItemWithQuickInputString:self.inputTextField.text];
    self.inputTextField.text = @""; 
    [self deselectButtons];
}

#pragma mark - HUD Buttons Actions

- (IBAction)todoTapped:(id)sender {
    UIButton *button = (UIButton*)sender;
    [self handleHUDTapForButton:button andActionString:@"t: "];
    [self.inputTextField becomeFirstResponder];
}

- (IBAction)finishedTapped:(id)sender {
    UIButton *button = (UIButton*)sender;
    [self handleHUDTapForButton:button andActionString:@"f: "];
}

- (IBAction)startTapped:(id)sender {
    UIButton *button = (UIButton*)sender;
    [self handleHUDTapForButton:button andActionString:@"s: "];
}

- (IBAction)meetingTapped:(id)sender {
    UIButton *button = (UIButton*)sender;
    [self handleHUDTapForButton:button andActionString:@"m: "];
}

- (IBAction)webTapped:(id)sender {
    UIButton *button = (UIButton*)sender;
    [self handleHUDTapForButton:button andActionString:@"i: "];
}

- (IBAction)walkinTapped:(id)sender {
    UIButton *button = (UIButton*)sender;
    [self handleHUDTapForButton:button andActionString:@"e: "];
}

#pragma mark - Quick Bar Buttons Actions

- (IBAction)durationTapped:(id)sender {
    if(!self.popoverController){
        self.popoverController = [[UIPopoverController alloc] initWithContentViewController:self.durationTableViewController];
    }
    [self.popoverController dismissPopoverAnimated:NO];
    [self.popoverController presentPopoverFromRect:self.durationButton.bounds inView:self.durationButton permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
    [self.popoverController setPopoverContentSize:CGSizeMake(150,5*44) animated:NO];
}

#pragma mark - UITextFieldDelegate

- (void)textFieldDidEndEditing:(UITextField *)textField {
// may be called if forced even if shouldEndEditing returns NO (e.g. view removed from window) or endEditing:YES called
    [textField resignFirstResponder];
    
}


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {   
    NSString *tobeString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    NSRange todoRange = [tobeString rangeOfString:@"t: "];
    if (todoRange.length == 0) {
        self.todoButton.selected = NO;
    } else {
        self.todoButton.selected = YES;
    }
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self okayTapped:textField];
    return YES;
}

#pragma mark - QTKTodoListDelegate

- (void)didSelecteTodoItem:(QTKTodoItem*)item {
    self.inputTextField.text = [NSString stringWithFormat:@"f: %@", item.titleClean];
    [self showQuickBar];
}

#pragma mark - QTKDurationListDelegate

- (void)didSelectDuration:(NSString *)duration {
    self.inputTextField.text = [self.inputTextField.text stringByAppendingString:duration];
    [self.popoverController dismissPopoverAnimated:YES];
}

@end
