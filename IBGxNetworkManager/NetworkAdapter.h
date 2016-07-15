//
//  NetworkAdapter.h
//  IBGxNetworkManager
//
//  Created by Adham Gad on 14,7//16.
//  Copyright © 2016 instabug. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetworkAdapter : NSObject


-(void)enqueueRequestWithURL:(NSURL *)url httpverb:(NSString *)verb andParameters:(NSArray *)params;
-(void)setMaxNumberOfConcurrentOperations:(NSInteger)max;

@end