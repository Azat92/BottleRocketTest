//
//  BRTDataLoadManager.m
//  BottleRocketTest
//
//  Created by Azat Almeev on 27.02.16.
//  Copyright © 2016 Azat Almeev. All rights reserved.
//

#import "BRTDataLoadManager.h"
#import "BRTNetManager.h"
#import <Mantle/Mantle.h>

@interface BRTDataLoadManager ()

@property (nonatomic, strong, readwrite) NSArray *items;

@property (nonatomic, copy) void (^newDataCallback)(NSArray *items);
@property (nonatomic, copy) void (^updateDataCallback)(NSArray *items);
@property (nonatomic, copy) void (^errorCallback)(NSError *error);

@end

@implementation BRTDataLoadManager

- (NSString *)loadingPath
{
    @throw [NSException exceptionWithName:@"Incorrect class setup" reason:@"You should override that property in subclass" userInfo:nil];
}

- (Class)modelClass
{
    @throw [NSException exceptionWithName:@"Incorrect class setup" reason:@"You should override that property in subclass" userInfo:nil];
}

+ (instancetype)managerWithNewDataCallback:(void (^)(NSArray *items))newData onUpdates:(void (^)(NSArray *items))update onError:(void (^)(NSError *error))error
{
    NSParameterAssert(newData != nil);
    NSParameterAssert(update != nil);
    NSParameterAssert(error != nil);
    BRTDataLoadManager *manager = [[[self class] alloc] initPrivate];
    manager.newDataCallback = newData;
    manager.updateDataCallback = update;
    manager.errorCallback = error;
    return manager;
}

- (instancetype)initPrivate
{
    self = [super init];
    return self;
}

- (instancetype)init
{
    @throw [NSException exceptionWithName:@"Incorrect method call" reason:@"You should use +managerWithNewDataCallback:onUpdates:onError: instead" userInfo:nil];
}

- (void)reloadData
{
    [BRTNetManager sendRequestWithPath:self.loadingPath method:BRTNetManagerMethodGET parameters:nil preprocess:^id(id JSONData, NSError *error) {
        return error ? JSONData : [MTLJSONAdapter modelsOfClass:self.modelClass fromJSONArray:[JSONData valueForKey:@"restaurants"] error:NULL];
    } completion:^(NSError *error, id JSONData) {
        if (!error)
        {
            BOOL hasData = self.items != nil;
            self.items = JSONData;
            if (hasData)
            {
                self.updateDataCallback(JSONData);
            }
            else
            {
                self.newDataCallback(JSONData);
            }
        }
        else
        {
            self.errorCallback(error);
        }
    }];
}

@end
