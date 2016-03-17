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


@property (weak, nonatomic) IBOutlet UITextField *radiusLabel;
@property (weak, nonatomic) IBOutlet UITextField *nameLabel;

@end

@implementation DetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"Latitude: %f Longitude: %f", self.annotation.coordinate.latitude, self.annotation.coordinate.longitude);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];

}

-(void)viewDidAppear:(BOOL)animated
{
    
    [super viewDidAppear:animated];
    
}


- (IBAction)saveLocationButton:(id)sender //when the user clicks save, its going to send the data back to the MKCircle and change radius based on users input
{
    Reminder *reminder = [[Reminder alloc]init];
    reminder.name = self.nameLabel.text;
    self.annotation.title = self.nameLabel.text;
    reminder.radius = (NSNumber *)self.radiusLabel.text;
    reminder.location = [PFGeoPoint geoPointWithLatitude:self.annotation.coordinate.latitude longitude:self.annotation.coordinate.longitude];
    
    if (self.completion) {
        if ([CLLocationManager isMonitoringAvailableForClass:[CLCircularRegion class]]) {
            CLCircularRegion *region = [[CLCircularRegion alloc]initWithCenter:self.annotation.coordinate radius:self.radiusLabel.text.floatValue identifier:reminder.name];
            [[[LocationController sharedController]locationManager]startMonitoringForRegion:region];
            self.completion([MKCircle circleWithCenterCoordinate:self.annotation.coordinate radius:self.radiusLabel.text.floatValue]);
            
            [[self navigationController]popViewControllerAnimated:YES];
        }
    }
    

}




@end
