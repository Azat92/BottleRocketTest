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

- (void)loadingViewDidClickRetryButton:(BRTLoadingView *)loadingView;

@end

@interface BRTLoadingView : UIView

@property (nonatomic, readonly) BRTLoadingViewMode mode;
@property (nonatomic, readonly) NSString *statusText;
@property (nonatomic, weak) id <BRTLoadingViewDelegate> delegate;

+ (instancetype)viewFromXib;
- (void)setErrorWithStatusText:(NSString *)text;

@end
