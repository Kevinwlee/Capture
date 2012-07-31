//
//  QTKQuickEntryTableViewController.m
//  Capture
//
//  Created by Kevin Lee on 7/27/12.
//  Copyright (c) 2012 Q Technology Company. All rights reserved.
//

#import "QTKQuickEntryTableViewController.h"

@interface QTKQuickEntryTableViewController ()

@end

@implementation QTKQuickEntryTableViewController
@synthesize items;
@synthesize delegate;

- (id)initWithStyle:(UITableViewStyle)style forQuickEntryItem:(QTKQuickEntryType)quickEntryType {
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
    
}

- (id)initWithStyle:(UITableViewStyle)style {
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewDidUnload {
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	return YES;
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
    cell.textLabel.text = [self.items objectAtIndex:indexPath.row];
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.delegate) {
        NSString * selectedItem = [self.items objectAtIndex:indexPath.row];
        [self.delegate didSelectEntry:[NSString stringWithFormat:@" %@", selectedItem]];
    }
}

@end
