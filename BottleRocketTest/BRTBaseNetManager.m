//
//  BRTBaseNetManager.m
//  BottleRocketTest
//
//  Created by Azat Almeev on 23.02.16.
//  Copyright © 2016 Azat Almeev. All rights reserved.
//

#import "BRTBaseNetManager.h"

@interface BRTBaseNetManager ()

@property (nonatomic, retain, readonly) NSURLSession *session;

@end

@implementation BRTBaseNetManager

@synthesize session = _session;

- (NSURLSession *)session
{
    if (!_session)
    {
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
        _session = [NSURLSession sessionWithConfiguration:config delegate:nil delegateQueue:[NSOperationQueue new]];
    }
    return _session;
}

- (void)sendRequest:(NSURLRequest *)request
     preprocessData:(id (^)(NSData *, NSURLResponse *, NSError *))preprocess
         completion:(void (^)(id, NSData *, NSURLResponse *, NSError *))completion
{
    [[self.session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        id processData = preprocess(data, response, error);
        dispatch_async(dispatch_get_main_queue(), ^{
            completion(processData, data, response, error);
        });
    }] resume];
}

@end
