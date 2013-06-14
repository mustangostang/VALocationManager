//
//  CLLocation+Formatting.m
//  FourFingers
//
//  Created by Vlad Andersen on 6/15/13.
//  Copyright (c) 2013 fourfingers. All rights reserved.
//

#import "CLLocation+Formatting.h"

@implementation CLLocation (Formatting)

- (NSString *) latString {
    return [NSString stringWithFormat:@"%g", self.coordinate.latitude];
}

- (NSString *) lngString {
    return [NSString stringWithFormat:@"%g", self.coordinate.longitude];
}


@end
