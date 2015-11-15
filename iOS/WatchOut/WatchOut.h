//
//  WatchOut.h
//  WatchOut
//
//  Created by Sreela Kodali on 11/15/15.
//  Copyright © 2015 Sreela Kodali. All rights reserved.
//

#import <PebbleKit/PebbleKit.h>

@interface WatchOut : NSObject <PBDataLoggingServiceDelegate>

@property (readonly) NSMutableArray *recordedData;

+ (instancetype)sharedWatchOut;

- (NSString *)connectionStatus;
- (NSUInteger)numberOfLogs;
- (void)resetData;

@end