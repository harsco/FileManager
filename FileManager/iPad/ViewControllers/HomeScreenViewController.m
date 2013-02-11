//
//  HomeScreenViewController.m
//  FileManager
//
//  Created by Mahi on 11/21/12.
//  Copyright (c) 2012 Mahi. All rights reserved.
//

#import "HomeScreenViewController.h"

@interface HomeScreenViewController ()

@end

@implementation HomeScreenViewController
@synthesize metalsButton;
@synthesize infraButton;

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
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)dealloc
{
    [super dealloc];
    
    [self.infraButton release];
    [self.metalsButton release];
    
    self.infraButton = nil;
    self.metalsButton = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}

-(IBAction)onMetalsButtonClicked:(id)sender
{
    
}

-(IBAction)onInfraButtonClicked:(id)sender
{
    InfraFilesViewController* infraFilesVC = [[InfraFilesViewController alloc] initWithPath:@"/"];
    
    [self presentViewController:infraFilesVC animated:YES completion:Nil];
    
    [infraFilesVC release];
}

@end
