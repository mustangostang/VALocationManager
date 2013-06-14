//
//  CLLocation+Formatting.h
//  FourFingers
//
//  Created by Vlad Andersen on 6/15/13.
//  Copyright (c) 2013 fourfingers. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>

@interface CLLocation (Formatting)

- (NSString *) latString;
- (NSString *) lngString;

@end
