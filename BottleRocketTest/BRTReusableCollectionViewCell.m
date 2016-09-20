//
//  BRTReusavleCollectionViewCell.m
//  BottleRocketTest
//
//  Created by Azat Almeev on 27.02.16.
//  Copyright © 2016 Azat Almeev. All rights reserved.
//

#import "BRTReusableCollectionViewCell.h"

@implementation BRTReusableCollectionViewCell

+ (NSString *)selfName
{
    return NSStringFromClass([self class]);
}

+ (UINib *)cellNib
{
    return [UINib nibWithNibName:self.selfName bundle:nil];
}

+ (NSString *)cellReuseIdentifier
{
    return [NSString stringWithFormat:@"%@Identifier", self.selfName];
}

@end
