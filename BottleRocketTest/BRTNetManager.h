//
//  BRTNetManager.h
//  BottleRocketTest
//
//  Created by Azat Almeev on 23.02.16.
//  Copyright © 2016 Azat Almeev. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef id (^BRTNetManagerPreprocess)(id JSONData, NSError *error);
typedef void (^BRTNetManagerCompletion)(NSError *error, id JSONData);

typedef enum : NSUInteger
{
    BRTNetManagerMethodGET,
    BRTNetManagerMethodPOST,
    BRTNetManagerMethodPUT,
    BRTNetManagerMethodPATCH,
    BRTNetManagerMethodDELETE
} BRTNetManagerMethod;

@interface BRTNetManager : NSObject

+ (void)sendRequestWithPath:(NSString *)path method:(BRTNetManagerMethod)method parameters:(NSDictionary *)parameters preprocess:(BRTNetManagerPreprocess)preprocess completion:(BRTNetManagerCompletion)completion;

@end
