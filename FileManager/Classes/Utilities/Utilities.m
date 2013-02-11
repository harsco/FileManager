//
//  Utilities.m
//  FileManager
//
//  Created by Mahi on 11/28/12.
//  Copyright (c) 2012 Mahi. All rights reserved.
//

#import "Utilities.h"

@implementation Utilities



+(Utilities*)getInstance
{
    static Utilities* instance;
     @synchronized(self)
    {
        if(!instance)
        {
            instance = [[Utilities alloc] init];
        }
    }
    
    return instance;
}


-(BOOL)isFileExists:(NSString*)filename
{
    
    NSLog(@"file name is %@",filename);
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *resourceDocPath = [[NSString alloc] initWithString:[[[[NSBundle mainBundle]  resourcePath] stringByDeletingLastPathComponent] stringByAppendingPathComponent:@"Documents"]];
    
    NSString *filePath = [resourceDocPath stringByAppendingPathComponent:filename];
    
    
    if ([fileManager fileExistsAtPath:filePath])
    {
        return YES;
    }
    return NO;
}

- (NSString *)stringForFileSize:(unsigned long long)fileSizeExact
{
    double  fileSize;
    NSString *  result;
    
    fileSize = (double) fileSizeExact;
    if (fileSizeExact == 1) {
        result = @"1 byte";
    } else if (fileSizeExact < 1024) {
        result = [NSString stringWithFormat:@"%llu bytes", fileSizeExact];
    } else if (fileSize < (1024.0 * 1024.0 * 0.1)) {
        result = [self stringForNumber:fileSize / 1024.0 asUnits:@"KB"];
    } else if (fileSize < (1024.0 * 1024.0 * 1024.0 * 0.1)) {
        result = [self stringForNumber:fileSize / (1024.0 * 1024.0) asUnits:@"MB"];
    } else {
        result = [self stringForNumber:fileSize / (1024.0 * 1024.0 * 1024.0) asUnits:@"MB"];
    }
    return result;
}

- (NSString *)stringForNumber:(double)num asUnits:(NSString *)units
{
    NSString *  result;
    double      fractional;
    double      integral;
    
    fractional = modf(num, &integral);
    if ( (fractional < 0.1) || (fractional > 0.9) ) {
        result = [NSString stringWithFormat:@"%.0f %@", round(num), units];
    } else {
        result = [NSString stringWithFormat:@"%.1f %@", num, units];
    }
    return result;
}

+(void)showAlertOKWithTitle:(NSString*)title withMessage:(NSString*)message{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                    message:message
                                                   delegate:nil
                                          cancelButtonTitle:@"Ok"
                                          otherButtonTitles:nil, nil];
    [alert show];
    [alert release];
    
}


@end
