//
//  TNEFContentViewController.h
//  TNEF Reader
//
//  Created by Arne Schmitz on 01.04.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuickLook/QLPreviewController.h>

@interface TNEFContentViewController : UITableViewController <QLPreviewControllerDataSource>

@property (nonatomic, retain) NSString *filePath;

- (void)refreshFileList;

@end
