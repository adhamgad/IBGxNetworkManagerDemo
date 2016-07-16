//
//  NetworkAdapter.h
//  IBGxNetworkManager
//
//  Created by Adham Gad on 14,7//16.
//  Copyright © 2016 instabug. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface NetworkAdapter : NSObject <NSURLSessionDelegate,NSURLSessionDownloadDelegate>


-(void)enqueueRequestWithURL:(NSURL *)url httpverb:(NSString *)verb parameters:(NSString *)params completionHandler:(void (^)(NSURL * location))completionHandler;

-(void)setMaxNumberOfConcurrentOperations:(NSInteger)max;

@end