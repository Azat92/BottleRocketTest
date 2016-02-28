//
//  BRTCustomTabBar.m
//  BottleRocketTest
//
//  Created by Azat Almeev on 22.02.16.
//  Copyright © 2016 Azat Almeev. All rights reserved.
//

#import "BRTCustomTabBar.h"

@implementation BRTCustomTabBar

+ (void)load
{
    [[UITabBarItem appearance] setTitleTextAttributes:@{ NSFontAttributeName : [UIFont fontWithName:@"Avenir Next" size:10] } forState:UIControlStateNormal];
}

- (CGSize)sizeThatFits:(CGSize)size
{
    CGSize sizeThatFits = [super sizeThatFits:size];
    sizeThatFits.height = 50;
    return sizeThatFits;
}

@end
