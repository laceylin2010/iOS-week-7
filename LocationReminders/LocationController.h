//
//  LocationController.h
//  LocationReminders
//
//  Created by Lacey Vu on 3/15/16.
//  Copyright © 2016 Lacey Vu. All rights reserved.
//

#import <Foundation/Foundation.h>
@import CoreLocation;


@protocol LocationControllerDelegate <NSObject>

-(void)locationControllerDidUpdateLocation:(CLLocation *)location;

@end


@interface LocationController : NSObject


@property(strong)CLLocationManager *locationManager;
@property(strong)CLLocationManager *location;
@property(weak)id delegate;


+(LocationController *)sharedController;

@end

#pragma mark - CLLocationManagerDelegate

@interface LocationController () <CLLocationManagerDelegate>

@end




