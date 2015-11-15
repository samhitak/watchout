//
//  WatchOutData.h
//  WatchOut
//
//  Created by Sreela Kodali on 11/15/15.
//  Copyright © 2015 Sreela Kodali. All rights reserved.
//

#import "AccelData.h"

@interface WatchOutData : NSObject

@property (readonly) AccelData *accelData;
@property (readonly) BOOL connectionStatus;

- (instancetype)initWithBytes:(const UInt8 *const)bytes andLength:(NSUInteger)length;
- (void)log;

@end