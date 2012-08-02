//
//  QTKDailyActivitLogTableViewController.m
//  Capture
//
//  Created by Lee, Kevin W. on 8/2/12.
//  Copyright (c) 2012 Q Technology Company. All rights reserved.
//

#import "QTKDailyActivitLogTableViewController.h"

@interface QTKDailyActivitLogTableViewController ()
- (void)handleAddItemNotification:(NSNotification *)notifcation;
- (void)addItem:(QTKTodoItem *)todoItem;
@end

@implementation QTKDailyActivitLogTableViewController
@synthesize items;

- (void)viewDidLoad {
    [super viewDidLoad];
    QTKTodoService *svc = [QTKTodoService sharedService];
    self.items = [NSMutableArray arrayWithArray:[svc allLogItems]];    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleAddItemNotification:) name:kLogItemAddedNotification object:nil];    
}

- (void)viewDidUnload {
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {    
    return [self.items count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    QTKTodoItem *item = [self.items objectAtIndex:indexPath.row];
    cell.textLabel.text = item.quickEntryText;
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.items removeObjectAtIndex:indexPath.row];        
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];        
    }   
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
}


@end
