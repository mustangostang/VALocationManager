VALocationManager
=================

CLLocationManager on iOS is incredibly powerful. However, most of the time you just want to get user location once.

Enter a simple, block-based API for doing that.

```objective-c
  + (void) getLocationWithAccuracy: (CLLocationAccuracy) accuracy
                            update: (void(^)(CLLocation* location)) update
                           success: (void(^)(CLLocation* location)) success
                           failure: (void(^)(NSError* error)) failure;
```

You really shouldn't use `kCLLocationAccuracyBest`, as it drains battery life (plus, the success block will probably 
never be called). `kCLLocationAccuracyNearestTenMeters` is more than enough for pretty much every use case (if you are
developping navigation software, you probably have some in-house recipe for handling CLLocationManager calls).

`Update` block is called on each location update (use it, for example, for moving user position on the map).

`Success` block is called when desired accuracy is reached (use it for queries based on location, like searching for something
based on location).

Handle errors with `failure` block.

Pretty much everything is optional, you can pass `nil` for every block.
