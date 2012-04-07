//
//  MasterViewController.h
//  TNEF Reader
//
//  Created by Arne Schmitz on 01.04.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuickLook/QLPreviewController.h>

@class DetailViewController;

@interface TNEFContentViewController : UITableViewController <QLPreviewControllerDataSource>

@property (strong, nonatomic) DetailViewController *detailViewController;
@property (nonatomic, retain) NSString *filePath;

@end
