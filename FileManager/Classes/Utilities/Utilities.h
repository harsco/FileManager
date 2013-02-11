//
//  Utilities.h
//  FileManager
//
//  Created by Mahi on 11/28/12.
//  Copyright (c) 2012 Mahi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Utilities : NSObject
{
    
}

+(Utilities*)getInstance;

-(BOOL)isFileExists:(NSString*)filename;
- (NSString *)stringForFileSize:(unsigned long long)fileSizeExact;
+(void)showAlertOKWithTitle:(NSString*)title withMessage:(NSString*)message;

@end
