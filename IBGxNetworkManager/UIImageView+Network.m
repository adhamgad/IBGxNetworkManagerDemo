//
//  UIImageView+Network.m
//  IBGxNetworkManager
//
//  Created by Adham Gad on 16,7//16.
//  Copyright © 2016 instabug. All rights reserved.
//

#import "UIImageView+Network.h"
#import "NetworkAdapter.h"

@implementation UIImageView (Network)

-(void)setImageWithURL:(NSURL *)url{
    NetworkAdapter *adapter = [[NetworkAdapter alloc]init];
    __block UIImage *img = [[UIImage alloc]init];
    
    UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    [spinner startAnimating];
    
    [adapter enqueueRequestWithURL:url httpverb:@"" parameters:@"" completionHandler:^(NSURL *location) {
        img = [UIImage imageWithContentsOfFile:[location path]];
        [spinner stopAnimating];
        self.image = img ;
    }];
    
    

}



@end
