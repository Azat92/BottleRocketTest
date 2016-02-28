//
//  BRTContact.m
//  BottleRocketTest
//
//  Created by Azat Almeev on 24.02.16.
//  Copyright © 2016 Azat Almeev. All rights reserved.
//

#import "BRTContact.h"

@implementation BRTContact

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{ @"formattedPhone" : @"formattedPhone",
              @"phone" : @"phone",
              @"twitter" : @"twitter" };
}

- (BOOL)havePhone
{
    return self.phone.length > 0 && self.formattedPhone.length > 0;
}

- (NSString *)twitter
{
    if (_twitter.length == 0)
    {
        return nil;
    }
    return [NSString stringWithFormat:@"@%@", _twitter];
}

@end
