//
//  ViewController.m
//  LocationReminders
//
//  Created by Lacey Vu on 3/14/16.
//  Copyright © 2016 Lacey Vu. All rights reserved.
//

#import "ViewController.h"
@import MapKit;
@import CoreLocation;

@interface ViewController ()

@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) CLLocationManager* locationManager;


@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupMapView];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];

}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self requestPermissions];
}

-(void)setupMapView
{
    self.mapView.layer.cornerRadius = 20;
    self.mapView.showsUserLocation = YES;
}

-(void)requestPermissions
{
    [self setLocationManager: [[CLLocationManager alloc]init]];
    [self.locationManager requestWhenInUseAuthorization];
    
}
- (IBAction)spaceNeedleButtonSelected:(UIButton *)sender
{

    CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(47.6204 , -122.349348);
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(coordinate, 500, 500);
    [_mapView setRegion:region animated:TRUE];
    

}

- (IBAction)statueOfLibertyButtonSelected:(UIButton *)sender
{

    CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(40.689247, -74.044502);
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(coordinate, 50, 500);
    [_mapView setRegion:region animated: TRUE];
}


- (IBAction)grandCanyonButtonSelected:(UIButton *)sender
{
    CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(36.056595, -112.125092);
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(coordinate, 500, 500);
    [_mapView setRegion:region animated:TRUE];

}


@end
