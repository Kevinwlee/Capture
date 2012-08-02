//
//  QTKLogTableViewController.m
//  Capture
//
//  Created by Kevin Lee on 7/24/12.
//  Copyright (c) 2012 Q Technology Company. All rights reserved.
//

#import "QTKLogTableViewController.h"

@interface QTKLogTableViewController ()
@property (nonatomic, strong) NSArray *datasource;
- (void)handleAddItemNotification:(NSNotification *)notifcation;
- (void)addItem:(QTKTodoItem *)todoItem;
@end

@implementation QTKLogTableViewController
@synthesize items = _items;
@synthesize tableView = _tableView;
@synthesize datasource = _datasource;


- (void)viewDidLoad {
    [super viewDidLoad];
    QTKTodoService *svc = [QTKTodoService sharedService];
    self.datasource = [svc allLogItemsGroupedByDay];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleAddItemNotification:) name:kLogItemAddedNotification object:nil];
}

- (void)viewDidUnload {
    [self setTableView:nil];
    [super viewDidUnload];
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	return YES;
}

- (void)handleAddItemNotification:(NSNotification *)notifcation {
    QTKTodoItem *item = notifcation.object;
    [self addItem:item];
}

- (void)addItem:(QTKTodoItem *)todoItem {
    [self.items insertObject:todoItem atIndex:0];
    [self.tableView beginUpdates];
    [self.tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationTop];
    [self.tableView endUpdates];
}

#pragma mark - Table view data source

- (NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    QTKTodoItem *firstItem = [[self.datasource objectAtIndex:section] objectAtIndex:0];
    return [NSString stringWithFormat:@"Completed On%@", firstItem.completedOnDate];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.datasource count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *sectionArray = [self.datasource objectAtIndex:section];
    return [sectionArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    // Configure the cell...
    NSArray *sectionArray = [self.datasource objectAtIndex:indexPath.section];
    QTKTodoItem *item = [sectionArray objectAtIndex:indexPath.row];
    cell.textLabel.text = item.quickEntryText;
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
}

- (IBAction)closeTapped:(id)sender {
    [self dismissModalViewControllerAnimated:YES];
}
@end
