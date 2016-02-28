//
//  BRTDataLoadManager.h
//  BottleRocketTest
//
//  Created by Azat Almeev on 27.02.16.
//  Copyright © 2016 Azat Almeev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BRTDataLoadManager : NSObject

@property (nonatomic, readonly) NSArray *items;
@property (nonatomic, readonly) NSString *loadingPath;
@property (nonatomic, readonly) Class modelClass;

+ (instancetype)managerWithNewDataCallback:(void (^)(NSArray *items))newData onUpdates:(void (^)(NSArray *items))update onError:(void (^)(NSError *error))error;
- (void)reloadData;

@end
