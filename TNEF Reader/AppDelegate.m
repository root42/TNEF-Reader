//
//  AppDelegate.m
//  TNEF Reader
//
//  Created by Arne Schmitz on 01.04.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"

#include "options.h"
#include "tnef.h"

@implementation AppDelegate

@synthesize window = _window;
@synthesize tempDirectory = _tempDirectory;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        UISplitViewController *splitViewController = (UISplitViewController *)self.window.rootViewController;
        UINavigationController *navigationController = [splitViewController.viewControllers lastObject];
        splitViewController.delegate = (id)navigationController.topViewController;
    }
    
    NSURL *url = (NSURL *)[launchOptions valueForKey:UIApplicationLaunchOptionsURLKey];
    [self initializeWithURL:url];
    
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)initializeWithURL:(NSURL *)url
{
    // Create temp dir if neccessary
    NSFileManager *fm = [NSFileManager defaultManager];
    self.tempDirectory = [NSString stringWithFormat:@"%@TNEF/", NSTemporaryDirectory()];
    [fm createDirectoryAtPath:self.tempDirectory withIntermediateDirectories:YES attributes:nil error:nil];
    
    // Make a copy of the string, cause parse_file wants a 'char *', not 'const char *'
    const char *tempDirC = [self.tempDirectory cStringUsingEncoding:NSUTF8StringEncoding]; 
    size_t tempDirLen = strlen(tempDirC);
    char *out_dir = malloc(tempDirLen);
    strlcpy(out_dir, tempDirC, tempDirLen);
    
    int flags = NONE;
    FILE *fp = NULL;
    
    if ([url isFileURL])
    {
        fp = fdopen([[NSFileHandle fileHandleForReadingFromURL:url error:NULL] fileDescriptor], "rb");
    } else {
        url = [[NSBundle mainBundle] URLForResource:@"winmail" withExtension:@"dat"];
        fp = fdopen([[NSFileHandle fileHandleForReadingFromURL:url error:NULL] fileDescriptor], "rb");
    }
    
    // Clear directory
    NSDirectoryEnumerator* en = [fm enumeratorAtPath:self.tempDirectory];
    NSError* err = nil;
    BOOL res;
    
    NSString* file;
    while (file = [en nextObject]) {
        res = [fm removeItemAtPath:[self.tempDirectory stringByAppendingPathComponent:file] error:&err];
        if (!res && err) {
            NSLog(@"oops: %@", err);
        }
    }
    
    // Now unpack the TNEF file
    int ret = parse_file (fp, 
                          out_dir, 
                          NULL /* body_file */, 
                          NULL /* body_pref */, 
                          flags);
    NSLog(@"TNEF returned: %i", ret);
    free(out_dir);
}

@end
