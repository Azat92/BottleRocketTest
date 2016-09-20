//
//  BRTRestaurnatsManager.m
//  BottleRocketTest
//
//  Created by Azat Almeev on 24.02.16.
//  Copyright © 2016 Azat Almeev. All rights reserved.
//

#import "BRTRestaurantsManager.h"

@implementation BRTRestaurantsManager

- (NSString *)loadingPath
{
    return @"BR_iOS_CodingExam_2015_Server/restaurants.json";
}

- (Class)modelClass
{
    return [BRTRestaurant class];
}

@end
