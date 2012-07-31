//
//  QTKDurationTableViewController.m
//  Capture
//
//  Created by Kevin Lee on 7/24/12.
//  Copyright (c) 2012 Q Technology Company. All rights reserved.
//

#import "QTKDurationTableViewController.h"

@interface QTKDurationTableViewController ()
@property (nonatomic, strong) NSArray *items;
@end

@implementation QTKDurationTableViewController
@synthesize items;
@synthesize delegate;

- (id)initWithStyle:(UITableViewStyle)style {
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.items = [NSArray arrayWithObjects:@"=15min",@"=30min",@"=45min",@"=1h",@"=1.5h", @"=", nil];
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
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
        [self.delegate didSelectDuration:[NSString stringWithFormat:@" %@", selectedItem]];
    }
}

@end
