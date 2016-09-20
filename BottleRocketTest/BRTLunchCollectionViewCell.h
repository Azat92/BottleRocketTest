//
//  BRTLunchCollectionViewCell.h
//  BottleRocketTest
//
//  Created by Azat Almeev on 22.02.16.
//  Copyright © 2016 Azat Almeev. All rights reserved.
//

#import "BRTReusableCollectionViewCell.h"
#import "BRTRestaurant.h"

static CGFloat const LUNCH_COLLECTION_CELL_HEIGHT = 180;

@interface BRTLunchCollectionViewCell : BRTReusableCollectionViewCell

@property (nonatomic, strong) BRTRestaurant *restaurant;

@end
