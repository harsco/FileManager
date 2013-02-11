//
//  InfraFilesViewController.h
//  FileManager
//
//  Created by Mahi on 11/21/12.
//  Copyright (c) 2012 Mahi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "App_TableViewController.h"
#import "Utilities.h"
#import "pdfViewer.h"
#import <MediaPlayer/MediaPlayer.h>


@interface InfraFilesViewController : App_TableViewController<dataSourceDelegate>
{
    DataSource* dataSource;
    NSString* pathName;
    
    UIProgressView* progress;
    
    NSInteger indexOfFile;
    
    BOOL isDownloadInProgress;
    
   
}

-(id)initWithPath:(NSString*)folderPath;


@end
