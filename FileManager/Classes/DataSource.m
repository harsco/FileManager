//
//  DataSource.m
//  FileManager
//
//  Created by Mahi on 11/26/12.
//  Copyright (c) 2012 Mahi. All rights reserved.
//

#import "DataSource.h"

@implementation DataSource
@synthesize delegate;




-(void)fetchInfraFilesListOfFolder:(NSString*)folderPath
{
    NSLog(@"%@",folderPath);
    
    operationType = FTP_FILELIST;
    
    WRRequestListDirectory * listDir = [[WRRequestListDirectory alloc] init];
    listDir.delegate = self;
    
    
    //the path needs to be absolute to the FTP root folder.
    //if we want to list the root folder we let the path nil or /
    //full URL would be ftp://xxx.xxx.xxx.xxx/
    //listDir.path = @"/Brochures and guides/General brochures";
    listDir.path = folderPath;
    
    listDir.hostname = @"ipadbdftp.harsco.com";
    listDir.username = @"ipadbd";
    listDir.password = @"1Pad8d";
    
    [listDir start];

}

-(void)downloadFile:(NSString*)fileName atFilePath:(NSString*)filePath
{
    
    NSLog(@"fileName is %@ and filepath is %@",fileName,filePath);
    operationType = FTP_FILEDOWNLOAD;
    fileNameToDownload = [[NSString alloc] initWithString:fileName];
    
    download = [[WRRequestDownload alloc] init];
    download.delegate = self;
    
    
    download.path = filePath;
    
    NSLog(@"path is %@",download.path);
    
    download.hostname = @"ipadbdftp.harsco.com";
    download.username = @"ipadbd";
    download.password = @"1Pad8d";
    
    [download start];
    
   // [download release];
    

}

-(void)cancelDownload
{
    [download destroy];
    
    download.delegate = nil;
    
    [download release];
}



#pragma mark- FTP delegate methods

-(void) requestCompleted:(WRRequest *) request
{
    //called after 'request' is completed successfully
    
   
    NSLog(@"%@ completed!", request);
    
    if(operationType == FTP_FILELIST)
    {
        //we cast the request to list request
        WRRequestListDirectory * listDir = (WRRequestListDirectory *)request;
        
        dataArray = [[NSMutableArray alloc] init];
        
        
        //we print each of the files name
        for (NSDictionary * fileDictionary in listDir.filesInfo) {
            NSLog(@"%@", [fileDictionary objectForKey:(id)kCFFTPResourceName]);
            NSLog(@"%@", [fileDictionary objectForKey:(id)kCFFTPResourceType]);
            NSLog(@"%lld", [[fileDictionary objectForKey:(id)kCFFTPResourceSize] longLongValue]);
            NSLog(@"%@",[fileDictionary objectForKey:(id)kCFFTPResourceLink]);
            
            file* obj = [[file alloc] init];
            
            obj.fileName = [fileDictionary objectForKey:(id)kCFFTPResourceName];
            
            
            obj.fileType = [obj.fileName pathExtension];
            obj.fileSize = [[fileDictionary objectForKey:(id)kCFFTPResourceSize] longLongValue];
            
            obj.fileSizeDisplay = [[Utilities getInstance] stringForFileSize:[[fileDictionary objectForKey:(id)kCFFTPResourceSize]  longLongValue]];
            
            NSLog(@"the extension is %@",[obj.fileName pathExtension]);
            
            if([[fileDictionary objectForKey:(id)kCFFTPResourceType] intValue] == 4)
            {
                obj.isFolder = YES;
            }
            else
            {
                obj.isFolder = NO;
            }
            
            //  obj.fileType = [[fileDictionary objectForKey:(id)kCFFTPResourceType] intValue];
            //obj.fileSize = [NSNumber numberWithLongLong:[file objectForKey:[(id)kCFFTPResourceSize]];
            
            
            //  obj.fileSize = [self stringForFileSize:[[fileDictionary objectForKey:(id)kCFFTPResourceSize] unsignedLongLongValue]];
            
            
            [dataArray addObject:obj];
            
            [obj release];
            
        }
        
        [delegate dataSourceDidFetchList:dataArray];
        
        [dataArray release];
        

    }
    
    if(operationType == FTP_FILEDOWNLOAD)
    {
        NSString *resourceDocPath = [[NSString alloc] initWithString:[[[[NSBundle mainBundle]  resourcePath] stringByDeletingLastPathComponent] stringByAppendingPathComponent:@"Documents"]];
        
        NSString *filePath = [resourceDocPath stringByAppendingPathComponent:fileNameToDownload];
        
        WRRequestDownload * downloadFile = (WRRequestDownload *)request;
        NSLog(@"path is %@",filePath);
        
        [downloadFile.receivedData writeToFile:filePath atomically:YES];
        [delegate didDownloadFile];
    }
        
           
}

-(void) requestFailed:(WRRequest *) request
{
   
    NSLog(@"%@", request.error.message);
    if(operationType == FTP_FILEDOWNLOAD)
    {
        [delegate didFailDownloadFile];
    }
    
}

-(void)fileSizeDownloaded:(NSInteger)fileSize
{
    [delegate updateProgress:fileSize];
}



@end
