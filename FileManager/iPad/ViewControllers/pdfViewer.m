//
//  pdfViewer.m
//  FileManager
//
//  Created by Mahi on 11/28/12.
//  Copyright (c) 2012 Mahi. All rights reserved.
//

#import "pdfViewer.h"

@interface pdfViewer ()

@end

@implementation pdfViewer
@synthesize pdfView;
@synthesize header;
@synthesize loadingIndicator;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(id)initWithPDFFileName:(NSString*)filename
{
    if(self = [super init])
    {
        fileName = [filename copy];
        
        
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.header.topItem.title = fileName;
    [self.loadingIndicator startAnimating];
    [self addBackButton];
    [self openFile];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}


-(void)addBackButton
{
    UIImage* image = [UIImage imageNamed:@"app_btn_back"];
    CGRect frameimg = CGRectMake(0, 0, image.size.width, image.size.height);
    
    UIButton *button = [[UIButton alloc] initWithFrame:frameimg];
    [button setBackgroundImage:image forState:UIControlStateNormal];
    [button addTarget:self action:@selector(onHomeClick:)
     forControlEvents:UIControlEventTouchUpInside];
    [button setShowsTouchWhenHighlighted:YES];
    
    UIBarButtonItem *backButton =[[[UIBarButtonItem alloc] initWithCustomView:button] autorelease];
    
    self.header.topItem.leftBarButtonItem = backButton;
}

-(void)openFile
{
    NSString *resourceDocPath = [[NSString alloc] initWithString:[[[[NSBundle mainBundle]  resourcePath] stringByDeletingLastPathComponent] stringByAppendingPathComponent:@"Documents"]];
    
    NSLog(@"path for resource is %@",resourceDocPath);
    
    NSString *filePath = [resourceDocPath stringByAppendingPathComponent:fileName];
    [self.pdfView loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:filePath]]];
}

#pragma mark-action methods
#pragma mark - Action Methods
-(void)onHomeClick:(id)sender
{
    [self.pdfView setDelegate:nil];
    [self dismissViewControllerAnimated:YES completion:Nil];
}

#pragma mark webview delegate
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [self.loadingIndicator stopAnimating];
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [self.loadingIndicator stopAnimating];

}

@end
