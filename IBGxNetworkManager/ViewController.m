//
//  ViewController.m
//  IBGxNetworkManager
//
//  Created by Adham Gad on 13,7//16.
//  Copyright © 2016 instabug. All rights reserved.
//

#import "ViewController.h"
#import "Reachability.h"
#import "NetworkAdapter.h"
#import "UIImageView+Network.h"

@interface ViewController ()


@property(nonatomic,strong) NetworkAdapter *adapter;

@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.adapter = [[NetworkAdapter alloc]init];
    
    if ([self checkReachability] == 1) {
        [self.adapter setMaxNumberOfConcurrentOperations:6];
    }else if ([self checkReachability] == 2){
        [self.adapter setMaxNumberOfConcurrentOperations:2];
    }
    
}


-(NSInteger)checkReachability{
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    [reachability startNotifier];
    
    NetworkStatus status = [reachability currentReachabilityStatus];
    
    if(status == NotReachable){
        return 0;
    }else if (status == ReachableViaWiFi){
        return 1;
    }else if (status == ReachableViaWWAN){
        return 2;
    }else{
        return -1;
    }
}



@end
