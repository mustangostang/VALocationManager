//
//  VALocationManager.h
//
//  Copyright (c) 2013 vlad.andersen@gmail.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import "CLLocation+Formatting.h"

@interface VALocationManager : NSObject<CLLocationManagerDelegate> {
    
}

@property (nonatomic, copy) void (^updateBlock) (CLLocation* location);
@property (nonatomic, copy) void (^failureBlock) (NSError *error);
@property (nonatomic, copy) void (^finallyBlock) (CLLocation* location, NSString *state);


+ (void) getLocationWithAccuracy: (CLLocationAccuracy) accuracy
                          update: (void(^)(CLLocation* location)) update;


+ (void) getLocationWithAccuracy: (CLLocationAccuracy) accuracy
                          update: (void(^)(CLLocation* location)) update
                         failure: (void(^)(NSError* error)) failure;

+ (void) getLocationWithAccuracy: (CLLocationAccuracy) accuracy
                          update: (void(^)(CLLocation* location)) update
                         failure: (void(^)(NSError* error)) failure
                         finally: (void(^)(CLLocation* location, NSString* state)) finally;

+ (void) getLocationWithAccuracy: (CLLocationAccuracy) accuracy
                         failure: (void(^)(NSError* error)) failure
                         finally: (void(^)(CLLocation* location, NSString* state)) finally;


@end
