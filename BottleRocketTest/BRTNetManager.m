//
//  BRTNetManager.m
//  BottleRocketTest
//
//  Created by Azat Almeev on 23.02.16.
//  Copyright © 2016 Azat Almeev. All rights reserved.
//

#import "BRTNetManager.h"

static NSString * const BASE_SERVER_URL = @"http://sandbox.bottlerocketapps.com/";

@interface BRTNetManager ()

@property (nonatomic, retain, readonly) NSURLSession *session;

@end

@implementation BRTNetManager

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

+ (instancetype)sharedInstance
{
    static id _singleton = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _singleton = [[self alloc] initSingleton];
    });
    return _singleton;
}

- (instancetype)init
{
    @throw [NSException exceptionWithName:@"You could not create an instance of this class" reason:@"This class is designed under the singleton pattern" userInfo:nil];
}

- (instancetype)initSingleton
{
    self = [super init];
    return self;
}

+ (void)sendRequestWithPath:(NSString *)path method:(BRTNetManagerMethod)method parameters:(NSDictionary *)parameters preprocess:(BRTNetManagerPreprocess)preprocess completion:(BRTNetManagerCompletion)completion
{
    NSURL *url = [BASE_SERVER_URL.toURL URLByAppendingPathComponent:path];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    switch (method)
    {
        case BRTNetManagerMethodGET:
            request.HTTPMethod = @"GET";
            break;
        case BRTNetManagerMethodPOST:
            request.HTTPMethod = @"POST";
            break;
        case BRTNetManagerMethodPUT:
            request.HTTPMethod = @"PUT";
            break;
        case BRTNetManagerMethodPATCH:
            request.HTTPMethod = @"PATCH";
            break;
        case BRTNetManagerMethodDELETE:
            request.HTTPMethod = @"DELETE";
            break;
    }
    if (parameters)
    {
        request.HTTPBody = [NSJSONSerialization dataWithJSONObject:parameters options:0 error:NULL];
        [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    }
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [[self sharedInstance] sendRequest:request preprocessData:^id(NSData *data, NSURLResponse *response, NSError *error) {
        id obj = data ? [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL] : nil;
        return preprocess ? preprocess(obj, error) : obj;
    } completion:^(id JSONData, NSData *data, NSURLResponse *response, NSError *error) {
        if ([response isKindOfClass:[NSHTTPURLResponse class]])
        {
            NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
            if (httpResponse.statusCode >= 200 && httpResponse.statusCode < 300)
            {
                completion(error, JSONData);
            }
            else
            {
                completion(error ?: NSErrorMakeFormat(@"Error code %ld", (long)httpResponse.statusCode), JSONData);
            }
        }
        else
        {
            completion(error ?: NSErrorMakeString(@"Unrecognized response"), JSONData);
        }
    }];
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
