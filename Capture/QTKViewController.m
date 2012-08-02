//
//  QTKViewController.m
//  Capture
//
//  Created by Kevin Lee on 7/24/12.
//  Copyright (c) 2012 Q Technology Company. All rights reserved.
//

#import "QTKViewController.h"
#import "QTKChronic.h"

@interface QTKViewController ()<UIPopoverControllerDelegate>
@property(nonatomic, strong) UIPopoverController *popoverController;
@property (nonatomic, strong) NSMutableArray *buttons;
@property (nonatomic, strong) NSDate* currentDate;
- (NSString *)cleanString;
- (void)showQuickBar;
- (void)hideQuickBar;
- (void)deselectButtons;
- (void)handleHUDTapForButton:(UIButton*)button andActionString:(NSString *)actionString;
- (void)displayQuickEntryListForType:(QTKQuickEntryType)type fromButton:(UIButton *)button;
- (NSString *)currentDayNumberString;
- (NSString *)currentMonthString;
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
@synthesize logView;
@synthesize dayNumberLabel;
@synthesize monthLabel;
@synthesize quickEntryView;
@synthesize popoverController;
@synthesize buttons;
@synthesize currentDate;

- (void)playWithDates {
    NSLog(@"Today: %@", [QTKChronic parse:@"Today"]);
    NSLog(@"tomorrow: %@", [QTKChronic parse:@"tomorrow"]);
    NSLog(@"Monday: %@", [QTKChronic parse:@"Monday"]);
    NSLog(@"tuesday: %@", [QTKChronic parse:@"tuesday"]);
    NSLog(@"wEDnesday: %@", [QTKChronic parse:@"wEDnesday"]);
    NSLog(@"thursday: %@", [QTKChronic parse:@"thursday"]);
    NSLog(@"friday: %@", [QTKChronic parse:@"friday"]);
    NSLog(@"saturday: %@", [QTKChronic parse:@"saturday"]);
    NSLog(@"sunday: %@", [QTKChronic parse:@"sunday"]);    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self playWithDates];
    self.currentDate = [NSDate date];
    self.dayNumberLabel.text = [self currentDayNumberString];
    self.monthLabel.text = [self currentMonthString];
    
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
    
}

- (void)viewDidUnload
{
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
    [self setLogView:nil];
    [self setDayNumberLabel:nil];
    [self setMonthLabel:nil];
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
- (NSString *)currentDayNumberString {
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"d"];
    NSString *day = [df stringFromDate:self.currentDate];
    return day;
}
- (NSString *)currentMonthString {
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"MMMM"];
    NSString *day = [df stringFromDate:self.currentDate];
    return day;
}

- (void)logDate {
    NSLog(@"day: %@", [self currentDayNumberString]);
    NSLog(@"month: %@", [self currentMonthString]);
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
    [self displayQuickEntryListForType:QTKQuickEntryDurations fromButton:sender];
}

- (IBAction)tagTapped:(id)sender {
    [self displayQuickEntryListForType:QTKQuickEntryTags fromButton:sender];
}

- (IBAction)projectTapped:(id)sender {
    [self displayQuickEntryListForType:QTKQuickEntryProjects fromButton:sender];
}

- (IBAction)peopleTapped:(id)sender {
    [self displayQuickEntryListForType:QTKQuickEntryPeople fromButton:sender];
}

- (IBAction)eventTapped:(id)sender {
    [self displayQuickEntryListForType:QTKQuickEntryEvents fromButton:sender];
}

- (IBAction)dueTapped:(id)sender {
    [self displayQuickEntryListForType:QTKQuickEntryDueDates fromButton:sender];
}

- (IBAction)actionTapped:(id)sender {
    [self displayQuickEntryListForType:QTKQuickEntryActions fromButton:sender];
}

- (IBAction)showActionItemsTapped:(id)sender {
}

- (IBAction)showLogTapped:(id)sender {
    QTKLogTableViewController *fullLogTableViewController = [[QTKLogTableViewController alloc] initWithNibName:@"QTKLogTableViewController" bundle:nil];
    fullLogTableViewController.modalPresentationStyle = UIModalPresentationFormSheet;
    [self presentModalViewController:fullLogTableViewController animated:YES];
}

- (void)displayQuickEntryListForType:(QTKQuickEntryType)type fromButton:(UIButton *)button {
    QTKQuickEntryTableViewController *quickEntryTableViewController = [[QTKQuickEntryTableViewController alloc] initWithNibName:@"QTKQuickEntryTableViewController" bundle:nil quickEntryType:type];
    quickEntryTableViewController.delegate = self;
    if(self.popoverController) {
        [self.popoverController dismissPopoverAnimated:YES];
        self.popoverController = nil;
        
    }    
    self.popoverController = [[UIPopoverController alloc] initWithContentViewController:quickEntryTableViewController];
    [self.popoverController presentPopoverFromRect:button.frame 
                                            inView:self.quickEntryView 
                          permittedArrowDirections:UIPopoverArrowDirectionUp 
                                          animated:YES];
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
    self.inputTextField.text = [NSString stringWithFormat:@"f: %@", item.text];
    [self showQuickBar];
}

#pragma mark - QTKDurationListDelegate

- (void)didSelectDuration:(NSString *)duration {
    self.inputTextField.text = [self.inputTextField.text stringByAppendingString:duration];
    [self.popoverController dismissPopoverAnimated:YES];
}

#pragma mark - QTKTagListDelegate

- (void)didSelectTag:(NSString *)tag {
    self.inputTextField.text = [self.inputTextField.text stringByAppendingString:tag];
    [self.popoverController dismissPopoverAnimated:YES];

}

#pragma mark - QTKQuickEntryDelegate

- (void)didSelectEntry:(NSString *)entry {
    self.inputTextField.text = [self.inputTextField.text stringByAppendingString:entry];
    [self.popoverController dismissPopoverAnimated:YES];    
}
@end
