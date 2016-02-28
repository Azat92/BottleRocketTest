//
//  BRTBaseNetManager.h
//  BottleRocketTest
//
//  Created by Azat Almeev on 23.02.16.
//  Copyright © 2016 Azat Almeev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BRTBaseNetManager : NSObject

- (void)sendRequest:(NSURLRequest *)request
     preprocessData:(id (^)(NSData *, NSURLResponse *, NSError *))preprocess
         completion:(void (^)(id, NSData *, NSURLResponse *, NSError *))completion;

@end
