//
//  MasterViewController.h
//  TNEF Reader
//
//  Created by Arne Schmitz on 01.04.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DetailViewController;

@interface TNEFContentViewController : UITableViewController

@property (strong, nonatomic) DetailViewController *detailViewController;

@end
