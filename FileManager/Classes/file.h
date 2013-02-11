//
//  file.h
//  FileManager
//
//  Created by Mahi on 11/26/12.
//  Copyright (c) 2012 Mahi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface file : NSObject
{
    NSString* fileName;
    NSString* fileType;
    long long fileSize;
    NSString* fileSizeDisplay;
    
    BOOL isFolder;
}

@property(nonatomic,retain)NSString* fileName;
@property(nonatomic,retain)NSString* fileType;
@property(nonatomic,retain)NSString* fileSizeDisplay;
@property(nonatomic) long long fileSize;
@property(nonatomic)BOOL isFolder;

@end
