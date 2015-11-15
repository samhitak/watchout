//
//  WatchOut.m
//  WatchOut
//
//  Created by Sreela Kodali on 11/15/15.
//  Copyright © 2015 Sreela Kodali. All rights reserved.
//

#import "WatchOut.h"

#import "AppDelegate.h"
#import "WatchOutData.h"


@implementation WatchOut

+ (instancetype)sharedWatchOut {
    static WatchOut *sharedWatchOut = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedWatchOut = [[self alloc] init];
    });
    return sharedWatchOut;
}

- (instancetype)init {
    if (self = [super init]) {
        _recordedData = [[NSMutableArray alloc] init];
    }
    return self;
}

- (NSString *)connectionStatus {
    return self.latestData.connectionStatus ? @"Connected" : @"Disconnected";
}

- (NSUInteger)numberOfLogs {
    return _recordedData.count;
}

- (WatchOutData *)latestData {
    return _recordedData.firstObject;
}

- (void)resetData {
    [_recordedData removeAllObjects];
}

#pragma mark - PBDataLoggingServiceDelegate

- (BOOL)dataLoggingService:(PBDataLoggingService *)service
             hasByteArrays:(const UInt8 *const)bytes
             numberOfItems:(UInt16)numberOfItems
     forDataLoggingSession:(PBDataLoggingSessionMetadata *)session {
    for (NSUInteger i = 0; i < numberOfItems; i++) {
        const uint8_t *logBytes = &bytes[i * session.itemSize];
        
        WatchOutData *data = [[WatchOutData alloc] initWithBytes:logBytes andLength:session.itemSize];
        [data log];
        
        [_recordedData insertObject:data atIndex:0];
    }
    
    return YES;
}

@end
