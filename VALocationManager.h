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
@property (nonatomic, copy) void (^successBlock) (CLLocation* location);
@property (nonatomic, copy) void (^failureBlock) (NSError *error);
@property (nonatomic, copy) void (^finallyBlock) ();


+ (void) getLocationWithAccuracy: (CLLocationAccuracy) accuracy
                          update: (void(^)(CLLocation* location)) update;

+ (void) getLocationWithAccuracy: (CLLocationAccuracy) accuracy
                          success: (void(^)(CLLocation* location)) success;

+ (void) getLocationWithAccuracy: (CLLocationAccuracy) accuracy
                         success: (void(^)(CLLocation* location)) success
                         failure: (void(^)(NSError* error)) failure;

+ (void) getLocationWithAccuracy: (CLLocationAccuracy) accuracy
                          update: (void(^)(CLLocation* location)) update
                         failure: (void(^)(NSError* error)) failure;

+ (void) getLocationWithAccuracy: (CLLocationAccuracy) accuracy
                          update: (void(^)(CLLocation* location)) update
                         success: (void(^)(CLLocation* location)) success
                         failure: (void(^)(NSError* error)) failure;

+ (void) getLocationWithAccuracy: (CLLocationAccuracy) accuracy
                         success: (void(^)(CLLocation* location)) success
                         failure: (void(^)(NSError* error)) failure
                         finally: (void(^)()) finally;

+ (void) getLocationWithAccuracy: (CLLocationAccuracy) accuracy
                          update: (void(^)(CLLocation* location)) update
                         success: (void(^)(CLLocation* location)) success
                         failure: (void(^)(NSError* error)) failure
                         finally: (void(^)()) finally;



@end
