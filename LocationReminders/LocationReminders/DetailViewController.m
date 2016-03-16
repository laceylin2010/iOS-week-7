//
//  DetailViewController.m
//  LocationReminders
//
//  Created by Lacey Vu on 3/15/16.
//  Copyright © 2016 Lacey Vu. All rights reserved.
//

#import "DetailViewController.h"
#import "Reminder.h"
#import "LocationController.h"

@interface DetailViewController ()


@end

@implementation DetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"%@", self.annotationTitle);
    NSLog(@"Latitude: %f Longitude: %f", self.coordinate.latitude, self.coordinate.longitude);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];

}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    Reminder *reminder = [[Reminder alloc]init];
    reminder.name = @"get food";
    reminder.radius = @100;
    reminder.location = [PFGeoPoint geoPointWithLatitude:self.coordinate.latitude longitude:self.coordinate.longitude];
    
    if (self.completion) {
        if ([CLLocationManager isMonitoringAvailableForClass:[CLCircularRegion class]]) {
            CLCircularRegion *region = [[CLCircularRegion alloc]initWithCenter:self.coordinate radius:100 identifier:@"Get Food"];
            [[[LocationController sharedController]locationManager]startMonitoringForRegion:region];
            self.completion([MKCircle circleWithCenterCoordinate:self.coordinate radius:100]);
            [[self navigationController]popViewControllerAnimated:YES];

        }
    }
    
    //user should be entering this information.
    //when clicking save need to verify validated data
}

@end
