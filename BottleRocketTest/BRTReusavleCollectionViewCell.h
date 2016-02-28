//
//  BRTReusavleCollectionViewCell.h
//  BottleRocketTest
//
//  Created by Azat Almeev on 27.02.16.
//  Copyright © 2016 Azat Almeev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BRTReusavleCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) id model;

+ (UINib *)cellNib;
+ (NSString *)cellReuseIdentifier;

@end
