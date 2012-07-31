//
//  QTKPathHelpers.m
//  Capture
//
//  Created by Kevin Lee on 7/28/12.
//  Copyright (c) 2012 Q Technology Company. All rights reserved.
//

#import "QTKPathHelpers.h"

NSString *PathForFileInDocumentsDirectory(NSString *filepath) {
    return [DocumentsDirectory() stringByAppendingPathComponent:filepath];
}

NSString * DocumentsDirectory() {
    NSString *docsDir = nil;
    NSArray *directories = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    if ([directories count] > 0)
        docsDir = [directories objectAtIndex:0];
    
    if(!docsDir) {
        [NSException raise:@"Critical Error" format:@"Can't find the documents directory!"];
    }
    
    return docsDir;
}
