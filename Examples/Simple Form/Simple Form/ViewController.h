//
//  ViewController.h
//  Simple Form
//
//  Created by Alan Ihre on 2013-10-30.
//  Copyright (c) 2013 Ihre IT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TableForm.h"

@interface ViewController : UITableViewController <TableFormDelegate>

@property (nonatomic,retain) TableForm *tableView;

@end
