//
//  NetworkAdapter.m
//  IBGxNetworkManager
//
//  Created by Adham Gad on 14,7//16.
//  Copyright © 2016 instabug. All rights reserved.
//

#import "NetworkAdapter.h"

@interface NetworkAdapter()

@property(strong) NSOperationQueue *queue;

@end

@implementation NetworkAdapter

-(id)init{
    
    self = [super init];
    
    if (self) {
        
        self.queue = [NSOperationQueue new];
        
    }
    return self;
}

-(void)enqueueRequestWithURL:(NSURL *)url httpverb:(NSString *)verb andParameters:(NSArray *)params{
    NSDictionary *request = @{@"url":url,
                              @"verb":verb ,
                              @"params": params};
    
    
    NSInvocationOperation *operation = [[NSInvocationOperation alloc]initWithTarget:self selector:@selector(createDownloadTask:) object:request];
    [self.queue addOperation:operation];
    
}

-(void)createDownloadTask:(NSDictionary *)request{
    NSString *dataURL = [request valueForKey:@"url"];
    NSURL *url = [NSURL URLWithString:dataURL];
    
    NSURLSessionDownloadTask *downloadTask = [[NSURLSession sharedSession]downloadTaskWithURL:url completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        //
    }];
    [downloadTask resume];
}

-(void)setMaxNumberOfConcurrentOperations:(NSInteger)max{
    self.queue.maxConcurrentOperationCount = max;
}


@end
