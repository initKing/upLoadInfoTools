//
//  NSURLRequest+CHAddtion.m
//  UploadInfoToNet
//
//  Created by CrazyHacker on 16/6/9.
//  Copyright © 2016年 CrazyHacker. All rights reserved.
//

#import "NSURLRequest+CHAddtion.h"

/// 上传分隔线
static NSString *boundary = @"myUpload";
@implementation NSURLRequest (CHAddtion)
+ (instancetype)ch_requestWithURL:(NSURL *)URL name:(NSString *)name filePath:(NSString *)filePath {
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:URL];
    
    request.HTTPMethod = @"POST";
    
    request.HTTPBody = [request cz_formDataWithName:name filePath:filePath];
    
    // 告诉服务器要上传文件
    NSString *type = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", boundary];
    [request setValue:type forHTTPHeaderField:@"Content-Type"];
    
    return request.copy;
}

- (NSData *)cz_formDataWithName:(NSString *)name filePath:(NSString *)filePath {
    
    NSMutableData *dataM = [NSMutableData data];
    
    // 1. 第一部分
    NSMutableString *strM = [NSMutableString string];
    [strM appendFormat:@"--%@\r\n", boundary];
    [strM appendFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"%@\"\r\n", name, filePath.lastPathComponent];
    [strM appendString:@"Content-Type: application/octet-stream\r\n\r\n"];
    
    [dataM appendData:[strM dataUsingEncoding:NSUTF8StringEncoding]];
    
    // 2. 第二部分
    NSData *fileData = [NSData dataWithContentsOfFile:filePath];
    [dataM appendData:fileData];
    
    // 3. 第三部分
    NSString *tail = [NSString stringWithFormat:@"\r\n--%@--", boundary];
    [dataM appendData:[tail dataUsingEncoding:NSUTF8StringEncoding]];
    
    return dataM.copy;
    
    }
@end
