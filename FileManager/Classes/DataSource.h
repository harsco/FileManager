//
//  DataSource.h
//  FileManager
//
//  Created by Mahi on 11/26/12.
//  Copyright (c) 2012 Mahi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WhiteRaccoon.h"
#import "file.h"
#import "ConstantDefines.h"
#import "Utilities.h"

@protocol dataSourceDelegate;


@interface DataSource : NSObject<WRRequestDelegate>
{
    id <dataSourceDelegate> delegate;
    NSMutableArray* dataArray;
    
    NSInteger operationType;
    
    NSString* fileNameToDownload;
    
    WRRequestDownload * download;
}


@property(nonatomic,retain)id<dataSourceDelegate>delegate;

-(void)fetchInfraFilesListOfFolder:(NSString*)folderPath;
-(void)downloadFile:(NSString*)fileName atFilePath:(NSString*)filePath;
-(void)cancelDownload;

@end


@protocol dataSourceDelegate <NSObject>

@optional

-(void)dataSourceDidFetchList:(NSMutableArray*)fileListArray;
-(void)dataSourceDidFailFetchingList:(NSError*)error;
-(void)didDownloadFile;
-(void)didFailDownloadFile;
-(void)updateProgress:(NSInteger)fileSizeDownloaded;



@end