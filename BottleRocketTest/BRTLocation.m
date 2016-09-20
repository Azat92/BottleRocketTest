//
//  BRTLocation.m
//  BottleRocketTest
//
//  Created by Azat Almeev on 24.02.16.
//  Copyright © 2016 Azat Almeev. All rights reserved.
//

#import "BRTLocation.h"

@implementation BRTLocation

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{ @"address" : @"address",
              @"cc" : @"cc",
              @"city" : @"city",
              @"country" : @"country",
              @"crossStreet" : @"crossStreet",
              @"formattedAddress" : @"formattedAddress",
              @"lat" : @"lat",
              @"lng" : @"lng",
              @"postalCode" : @"postalCode",
              @"state" : @"state" };
}

- (NSString *)fullAddress {
    return [self.formattedAddress componentsJoinedByString:@", "];
}

@end
