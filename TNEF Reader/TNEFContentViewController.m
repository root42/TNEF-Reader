//
//  TNEFContentViewController.m
//  TNEF Reader
//
//  Created by Arne Schmitz on 01.04.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TNEFContentViewController.h"

#import "AppDelegate.h"
#import "FileListCell.h"


@interface TNEFContentViewController () 
@property (nonatomic, retain) NSArray *fileNames;
@end

@interface TNEFContentViewController () 
{
    NSMutableArray *_objects;
}
@end

@implementation TNEFContentViewController

@synthesize filePath = _filePath;
@synthesize fileNames = _fileNames;

- (void)awakeFromNib
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        self.clearsSelectionOnViewWillAppear = NO;
        self.contentSizeForViewInPopover = CGSizeMake(320.0, 600.0);
    }
    [super awakeFromNib];
}

- (void)viewDidLoad
{
    ((AppDelegate*)[UIApplication sharedApplication].delegate).tnefContentViewController = self;
    [super viewDidLoad];
    [self refreshFileList];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.

    // more clean up
    ((AppDelegate*)[UIApplication sharedApplication].delegate).tnefContentViewController = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

- (void)insertNewObject:(id)sender
{
    if (!_objects) {
        _objects = [[NSMutableArray alloc] init];
    }
    [_objects insertObject:[NSDate date] atIndex:0];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.fileNames.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FileListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];

    cell.title.text = [self.fileNames objectAtIndex:indexPath.row];
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [_objects removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}

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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // When user taps a row, create the preview controller
    QLPreviewController *previewer = [[QLPreviewController alloc] init];
    
    // Set data source
    [previewer setDataSource:self];
    
    // Which item to preview
    [previewer setCurrentPreviewItemIndex:indexPath.row];
    
    // Push new viewcontroller, previewing the document
    [[self navigationController] pushViewController:previewer animated:YES];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        [[segue destinationViewController] setCurrentPreviewItemIndex:indexPath.row];
    }
}

#pragma mark --
#pragma mark File list parsing

- (void)refreshFileList
{
    self.filePath = ((AppDelegate*)[UIApplication sharedApplication].delegate).tempDirectory;
    NSFileManager *fm = [NSFileManager defaultManager];
    self.fileNames = [fm contentsOfDirectoryAtPath:self.filePath error:nil];
    [self.tableView reloadData];
}

#pragma mark --
#pragma mark QuickLook delegate

- (NSInteger) numberOfPreviewItemsInPreviewController: (QLPreviewController *) controller 
{
    return [self.fileNames count];
}

- (id <QLPreviewItem>)previewController: (QLPreviewController *)controller previewItemAtIndex:(NSInteger)index 
{
    NSString *fileName = [self.fileNames objectAtIndex:index];
    NSString *path = [NSString stringWithFormat:@"%@/%@", self.filePath, fileName];
    
    return [NSURL fileURLWithPath:path];
}

@end
