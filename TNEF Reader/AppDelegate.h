//
//  AppDelegate.h
//  TNEF Reader
//
//  Created by Arne Schmitz on 01.04.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "TNEFContentViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (retain, nonatomic) NSString *tempDirectory;
@property (retain, nonatomic) IBOutlet TNEFContentViewController *tnefContentViewController;

@end
