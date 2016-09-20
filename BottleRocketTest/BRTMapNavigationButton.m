//
//  BRTMapNavigationButton.m
//  BottleRocketTest
//
//  Created by Azat Almeev on 20.09.16.
//  Copyright © 2016 Azat Almeev. All rights reserved.
//

#import "BRTMapNavigationButton.h"

@implementation BRTMapNavigationButton

+ (BRTMapNavigationButton *)readyToGoButton
{
    BRTMapNavigationButton *button = [BRTMapNavigationButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:@"btn_mapNavigate"] forState:UIControlStateNormal];
    [button sizeToFit];
    return button;
}

@end
