//
//  LocationController.m
//  LocationReminders
//
//  Created by Lacey Vu on 3/15/16.
//  Copyright © 2016 Lacey Vu. All rights reserved.
//

#import "LocationController.h"

@implementation LocationController

+(LocationController *)sharedController
{
    static LocationController *sharedController = nil;
    static dispatch_once_t onceToken;
dispatch_once(&onceToken, ^{
    sharedController = [[self.class alloc]init];
});
    
    return sharedController;
    
}

-(instancetype)init
{
    self = [super init];
    if (self) {
        _locationManager = [[CLLocationManager alloc]init];
        _locationManager.delegate = self;
        _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        _locationManager.distanceFilter = 100;
    }
    
    [_locationManager requestWhenInUseAuthorization];
    
    return self;
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations
{
    [self.delegate locationControllerDidUpdateLocation:[locations lastObject]];
    
}






@end



