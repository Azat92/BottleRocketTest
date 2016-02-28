//
//  BRTLoadingView.h
//  BottleRocketTest
//
//  Created by Azat Almeev on 23.02.16.
//  Copyright © 2016 Azat Almeev. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BRTLoadingView;

typedef enum : NSUInteger
{
    BRTLoadingViewModeLoading,
    BRTLoadingViewModeError
} BRTLoadingViewMode;

@protocol BRTLoadingViewDelegate <NSObject>

- (void)loadingViewDidCLickRetryButton:(BRTLoadingView *)loadingView;

@end

@interface BRTLoadingView : UIView

@property (nonatomic, assign) BRTLoadingViewMode mode;
@property (nonatomic, copy) NSString *statusText;
@property (nonatomic, weak) id <BRTLoadingViewDelegate> delegate;

+ (instancetype)viewFromXib;

@end
