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
@property (nonatomic,strong) void (^completionHandler)(NSURL *) ;

@end

@implementation NetworkAdapter

-(id)init{
    
    self = [super init];

    if (self) {
        
        self.queue = [NSOperationQueue new];
        
    }
    return self;
}

-(void)enqueueRequestWithURL:(NSURL *)url httpverb:(NSString *)verb parameters:(NSString *)params completionHandler:(void (^)(NSURL * location))completionHandler{
    self.completionHandler = completionHandler;
    NSDictionary *request = @{@"url":url,
                              @"verb":verb ,
                              @"params": params};
    
    NSInvocationOperation *operation = [[NSInvocationOperation alloc]initWithTarget:self selector:@selector(createDownloadTask:) object:request];
    [self.queue addOperation:operation];
}

#pragma mark - helper methods

-(void)setMaxNumberOfConcurrentOperations:(NSInteger)max{
    self.queue.maxConcurrentOperationCount = max;
}


-(void)createDownloadTask:(NSDictionary *)request{
 

    NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration backgroundSessionConfigurationWithIdentifier:@"ibgx"];

    NSURLSession *session = [NSURLSession sessionWithConfiguration:sessionConfiguration delegate:self delegateQueue:nil];
    
    NSString *dataURL = [NSString stringWithFormat:@"%@", request[@"url"]];
    NSURL *url = [NSURL URLWithString:dataURL];
    
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];
    NSString *params = request[@"params"];
    [urlRequest setHTTPMethod:request[@"verb"]];
    [urlRequest setHTTPBody:[params dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSURLSessionDownloadTask *downloadTask = [session downloadTaskWithRequest:urlRequest];
    
    
    [downloadTask resume];
}

#pragma mark - Delegate methods 

- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(NSURL *)downloadURL {

    NSFileManager *fileManager = [[NSFileManager alloc] init];
    
    NSArray *documentURLs = [fileManager URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask];
    NSURL *documentsDirectory = [documentURLs firstObject];
    
    NSString *sendingFileName = [downloadTask.originalRequest.URL lastPathComponent];
    NSURL *destinationUrl = [documentsDirectory URLByAppendingPathComponent:sendingFileName];
    
    NSData *fileData = [NSData dataWithContentsOfURL:downloadURL];
    [fileData writeToURL:destinationUrl atomically:NO];
    self.completionHandler(destinationUrl);

}

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error {
    
    if (error == nil) {
        NSLog(@"Task: %@ completed successfully", task);
    } else {
        NSLog(@"Task: %@ completed with error: %@", task, [error localizedDescription]);
    }
    
}




@end
