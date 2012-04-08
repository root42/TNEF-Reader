//
//  AboutDialogViewController.m
//  TNEF Reader
//
//  Created by Arne Schmitz on 08.04.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AboutDialogViewController.h"

@interface AboutDialogViewController ()

@end

@implementation AboutDialogViewController

@synthesize aboutView = _aboutView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self.aboutView loadRequest:[NSURLRequest requestWithURL:[[NSBundle mainBundle] URLForResource:@"about"
                                                                                    withExtension:@"html"]]];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
