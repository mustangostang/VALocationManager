//
//  VALocationManager.m
//
//  Copyright (c) 2013 vlad.andersen@gmail.com. All rights reserved.
//

#import "VALocationManager.h"
#define VA_LOCATION_MANAGER_TIMEOUT 30


@interface VALocationManager() {
    
}
    @property (nonatomic, retain) CLLocationManager *locationManager;
    @property (nonatomic, retain) NSMutableArray *locationMeasurements;
    @property (nonatomic, retain) CLLocation *bestEffortAtLocation;

@end


@implementation VALocationManager


+ (void) getLocationWithAccuracy: (CLLocationAccuracy) accuracy
                          update: (void(^)(CLLocation* location)) update
                         failure: (void(^)(NSError* error)) failure
                         finally: (void(^)(CLLocation* location, NSString* state)) finally
{
    VALocationManager *manager = [[VALocationManager alloc] init];
    manager.locationManager.desiredAccuracy = accuracy;
    manager.updateBlock = (update);
    manager.failureBlock = (failure);
    manager.finallyBlock = (finally);
    [manager.locationManager startUpdatingLocation];
    [manager performSelector:@selector(stopUpdatingLocation) withObject:nil afterDelay: VA_LOCATION_MANAGER_TIMEOUT];
}

+ (void) getLocationWithAccuracy: (CLLocationAccuracy) accuracy
                          update: (void(^)(CLLocation* location)) update
{
    [self getLocationWithAccuracy: accuracy update: update failure: nil finally: nil];
}


+ (void) getLocationWithAccuracy: (CLLocationAccuracy) accuracy
                          update: (void(^)(CLLocation* location)) update
                         failure: (void(^)(NSError* error)) failure
{
    [self getLocationWithAccuracy: accuracy
                           update: update
                          failure: failure
                          finally: nil];
}

+ (void) getLocationWithAccuracy: (CLLocationAccuracy) accuracy
                         failure: (void(^)(NSError* error)) failure
                         finally: (void(^)(CLLocation* location, NSString* state)) finally
{
    [self getLocationWithAccuracy: accuracy
                           update: nil
                          failure: failure
                          finally: finally];
}



- (VALocationManager *) init
{
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters;
    self.bestEffortAtLocation = nil;
    return self;
}


#pragma mark Location functions

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
    [self.locationMeasurements addObject:newLocation];
    NSTimeInterval locationAge = -[newLocation.timestamp timeIntervalSinceNow];
    if (locationAge > 5.0) return;
    if (self.bestEffortAtLocation != nil && self.bestEffortAtLocation.horizontalAccuracy <= newLocation.horizontalAccuracy) return;
    self.bestEffortAtLocation = newLocation;
    if (self.updateBlock != nil) { self.updateBlock(newLocation); }
    if (newLocation.horizontalAccuracy <= self.locationManager.desiredAccuracy) {
        if (self.finallyBlock != nil) { self.finallyBlock(newLocation, @"Success"); }
        [self stopUpdatingLocation];
        [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(stopUpdatingLocation) object:nil];
    }
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    if ([error code] != kCLErrorLocationUnknown) {
        [self stopUpdatingLocation];
    }
    if (self.failureBlock != nil) { self.failureBlock(error); }
    if (self.finallyBlock != nil) { self.finallyBlock(nil, @"Error"); }
}

- (void)stopUpdatingLocation {
    [self.locationManager stopUpdatingLocation];
    self.locationManager.delegate = nil;
}

- (void) timeOut {
    [self stopUpdatingLocation];
    NSError *error = [NSError errorWithDomain:@"com.CLLocationmanager" code:1 userInfo: @{ NSLocalizedDescriptionKey: @"CLLocationManager timed out"}];
    if (self.failureBlock != nil) { self.failureBlock(error); }
    if (self.finallyBlock != nil) { self.finallyBlock(nil, @"Timed out"); }

}



@end