#import <Foundation/Foundation.h>

@interface AccelData : NSObject

@property (readonly) int16_t x;
@property (readonly) int16_t y;
@property (readonly) int16_t z;
@property (readonly) BOOL didVibrate;
@property (readonly) uint64_t timestamp;

- (instancetype)initWithData:(NSData *)data;

@end