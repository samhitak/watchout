//
//  WatchOutData.m
//  WatchOut
//
//  Created by Sreela Kodali on 11/15/15.
//  Copyright © 2015 Sreela Kodali. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "WatchOutData.h"
#import "AccelData.h"

@implementation WatchOutData


- (instancetype)initWithBytes:(const UInt8 *const)bytes andLength:(NSUInteger)length {
    
    NSMutableData *data = [NSMutableData dataWithBytes:bytes length:length];
    
    
    
    const void *subdataBytes;
    NSRange range = {0, 0};
    
    range.location += range.length;
    range.length = 4;
    subdataBytes = [[data subdataWithRange:range] bytes];
    
    _accelData = [[AccelData alloc] initWithData:[data subdataWithRange:range]];
    
    range.location += range.length;
    range.length = 4;
    subdataBytes = [[data subdataWithRange:range] bytes];
    
    return self;

}


- (void)log {
    NSLog(@"=========================================================================");
    NSLog(@"accel:\t\t\t\t%05d\t%05d\t%05d\t%d\t%llu", _accelData.x, _accelData.y, _accelData.z, _accelData.didVibrate, _accelData.timestamp);
}

@end
