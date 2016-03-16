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
    
}


- (IBAction)saveLocationButton:(id)sender //when the user clicks save, its going to send the data back to the MKCircle and change radius based on users input
{
    Reminder *reminder = [[Reminder alloc]init];
    reminder.name = self.nameLabel.text;;
    reminder.radius = (NSNumber *)self.radiusLabel.text;
    reminder.location = [PFGeoPoint geoPointWithLatitude:self.coordinate.latitude longitude:self.coordinate.longitude];
    
    __weak typeof (self) weakSelf = self;
    if (weakSelf.completion) {
        if ([CLLocationManager isMonitoringAvailableForClass:[CLCircularRegion class]]) {
            CLCircularRegion *region = [[CLCircularRegion alloc]initWithCenter:self.coordinate radius:self.radiusLabel.text.floatValue identifier:reminder.name];
            [[[LocationController sharedController]locationManager]startMonitoringForRegion:region];
            weakSelf.completion([MKCircle circleWithCenterCoordinate:self.coordinate radius:self.radiusLabel.text.floatValue]);
            
            [[self navigationController]popViewControllerAnimated:YES];
        }
    }
    

}




@end
