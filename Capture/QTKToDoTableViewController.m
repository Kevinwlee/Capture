//
//  QTKToDoTableViewController.m
//  Capture
//
//  Created by Kevin Lee on 7/24/12.
//  Copyright (c) 2012 Q Technology Company. All rights reserved.
//

#import "QTKToDoTableViewController.h"
#import "QTKTodoItem.h"

@interface QTKToDoTableViewController ()
- (void)handleAddItemNotification:(NSNotification *)notifcation;
- (void)addItem:(QTKTodoItem *)todoItem;
- (void)loadData;
@end

@implementation QTKToDoTableViewController
@synthesize delegate;
@synthesize items = _items;

- (id)initWithStyle:(UITableViewStyle)style {
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadData];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleAddItemNotification:) name:kTodoItemAddedNotification object:nil];
}

- (void)viewDidUnload {
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}
- (void)loadData {
    QTKTodoService *svc = [QTKTodoService sharedService];
    self.items = [NSMutableArray arrayWithArray:[svc openTodoItems]];
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.items count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    // Configure the cell...
    QTKTodoItem *item = [self.items objectAtIndex:indexPath.row];
    cell.textLabel.text = item.title;
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.delegate) {
        QTKTodoItem *selectedItem = [self.items objectAtIndex:indexPath.row];
        [self.delegate didSelecteTodoItem:selectedItem];
        selectedItem.completed = YES;
        [[NSNotificationCenter defaultCenter] postNotificationName:kTodoItemChangedNotification object:selectedItem];
        [self loadData];
        [self.tableView reloadData];
    }
}

@end
