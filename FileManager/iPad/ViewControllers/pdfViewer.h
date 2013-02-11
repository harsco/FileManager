//
//  pdfViewer.h
//  FileManager
//
//  Created by Mahi on 11/28/12.
//  Copyright (c) 2012 Mahi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface pdfViewer : UIViewController<UIWebViewDelegate>
{
    IBOutlet UIWebView* pdfView;
    IBOutlet UINavigationBar* header;
    IBOutlet UIActivityIndicatorView* loadingIndicator;
    
    NSString* fileName;
    
    
}


@property(nonatomic,retain)UIWebView* pdfView;
@property(nonatomic,retain)UINavigationBar* header;
@property(nonatomic,retain)UIActivityIndicatorView* loadingIndicator;

-(id)initWithPDFFileName:(NSString*)filename;

@end
