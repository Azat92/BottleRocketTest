//
//  BRTRestaurant.m
//  BottleRocketTest
//
//  Created by Azat Almeev on 24.02.16.
//  Copyright © 2016 Azat Almeev. All rights reserved.
//

#import "BRTRestaurant.h"

@implementation BRTRestaurant

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{ @"backgroundImageURL" : @"backgroundImageURL",
              @"category" : @"category",
              @"name" : @"name",
              @"contact" : @"contact",
              @"location" : @"location" };
}

+ (NSValueTransformer *)contactJSONTransformer
{
    return [MTLValueTransformer transformerUsingForwardBlock:^id(NSDictionary *contactDict, BOOL *success, NSError *__autoreleasing *error) {
        return [MTLJSONAdapter modelOfClass:[BRTContact class] fromJSONDictionary:contactDict error:NULL];
    }];
}

+ (NSValueTransformer *)locationJSONTransformer
{
    return [MTLValueTransformer transformerUsingForwardBlock:^id(NSDictionary *locationDict, BOOL *success, NSError *__autoreleasing *error) {
        return [MTLJSONAdapter modelOfClass:[BRTLocation class] fromJSONDictionary:locationDict error:NULL];
    }];
}

#pragma mark - Annotation Protocol

- (CLLocationCoordinate2D)coordinate
{
    return CLLocationCoordinate2DMake([self.location.lat doubleValue], [self.location.lng doubleValue]);
}

- (NSString *)title
{
    return self.name;
}

- (NSString *)subtitle
{
    return self.category;
}

@end
