//
//  NSURLRequest+CHAddtion.h
//  UploadInfoToNet
//
//  Created by CrazyHacker on 16/6/9.
//  Copyright © 2016年 CrazyHacker. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSURLRequest (CHAddtion)
+ (instancetype)ch_requestWithURL:(NSURL *)URL name:(NSString *)name filePath:(NSString *)filePath;
@end
