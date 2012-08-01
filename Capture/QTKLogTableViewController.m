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
@synthesize datasource = _datasource;

- (id)initWithStyle:(UITableViewStyle)style {
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    QTKTodoService *svc = [QTKTodoService sharedService];
    self.items = [NSMutableArray arrayWithArray:[svc allLogItems]];

    self.datasource = [svc allLogItemsGroupedByDay];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleAddItemNotification:) name:kLogItemAddedNotification object:nil];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
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
//- (NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
//    QTKTodoItem *firstItem = [[self.datasource objectAtIndex:section] objectAtIndex:0];
//    return [NSString stringWithFormat:@"Completed On%@", firstItem.completedOnDate];
//}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//    return [self.datasource count];
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
//    NSArray *sectionArray = [self.datasource objectAtIndex:section];
//    return [sectionArray count];
    return [self.items count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    // Configure the cell...
//    NSArray *sectionArray = [self.datasource objectAtIndex:indexPath.section];
//    QTKTodoItem *item = [sectionArray objectAtIndex:indexPath.row];
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

/*
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
*/

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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

@end
