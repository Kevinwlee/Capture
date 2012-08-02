//
//  QTKLogTableViewController.h
//  Capture
//
//  Created by Kevin Lee on 7/24/12.
//  Copyright (c) 2012 Q Technology Company. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QTKTodoService.h"

@interface QTKLogTableViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong)NSMutableArray *items;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

- (IBAction)closeTapped:(id)sender;
@end
