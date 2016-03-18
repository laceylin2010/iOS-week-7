//
//  ViewController.m
//  LocationReminders
//
//  Created by Lacey Vu on 3/14/16.
//  Copyright © 2016 Lacey Vu. All rights reserved.
//

#import "ViewController.h"
#import "LocationController.h"
#import "DetailViewController.h"
#import "Reminder.h"
#import <Parse/Parse.h>
#import <ParseUI/ParseUI.h>


@import MapKit;
@import CoreLocation;

@interface ViewController () <MKMapViewDelegate, PFLogInViewControllerDelegate, PFSignUpViewControllerDelegate, LocationControllerDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) CLLocationManager* locationManager;


- (IBAction)locationButtons:(UIButton *)sender;


@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self login];
    [self setupMapView];
    [self.mapView setDelegate:self];
    [self getReminders];
    

}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[LocationController sharedController]setDelegate:self];
    [[[LocationController sharedController]locationManager]startUpdatingLocation];

      
}

-(void)locationControllerDidUpdateLocation:(CLLocation *)location
{
    
    CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude);
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(coordinate, 500, 500);
    [_mapView setRegion:region animated:TRUE];
}


-(void)viewWillDisappear:(BOOL)animated
{
    [[[LocationController sharedController]locationManager]stopUpdatingLocation];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];

}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];

}

-(void)login
{
    if (![PFUser currentUser]) {
        PFLogInViewController *loginViewController = [[PFLogInViewController alloc]init];
        loginViewController.delegate = self;
        loginViewController.signUpController.delegate = self;
        [self presentViewController:loginViewController animated:YES completion:nil];
    } else {
        [self setupAdditionUI];
    }
}

-(void)setupAdditionUI
{
    UIBarButtonItem *signOutButton = [[UIBarButtonItem alloc]initWithTitle:@"Sign Out" style:UIBarButtonItemStylePlain target:self action:@selector(signOut)];
    self.navigationItem.leftBarButtonItem = signOutButton;
}

-(void)signOut
{
    [PFUser logOut];
    [self login];
}

-(void)logInViewController:(PFLogInViewController *)logInController didLogInUser:(PFUser *)user
{
    [self dismissViewControllerAnimated:YES completion:nil];
    [self setupAdditionUI];
}

-(void)signUpViewController:(PFSignUpViewController *)signUpController didSignUpUser:(PFUser *)user
{
    [self dismissViewControllerAnimated:YES completion:nil];
    [self setupAdditionUI];
}

-(void)setupMapView
{
    self.mapView.layer.cornerRadius = 20;
    self.mapView.showsUserLocation = YES;
}

-(void)getReminders
{
    PFQuery *query = [PFQuery queryWithClassName:@"Reminder"];
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        if (error == nil && objects) {
         
        }
        for (Reminder *object in objects) {
            CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(object.location.latitude, object.location.longitude);
            MKPointAnnotation *newPoint = [[MKPointAnnotation alloc]init];
            MKCircle *circle = [MKCircle circleWithCenterCoordinate:coordinate radius: object.radius.floatValue];
            
            newPoint.coordinate = coordinate;
//            newPoint.
             //adding title to the pin
            //add to reminders if noting exists

            [self.mapView addAnnotation: newPoint];
            [self.mapView addOverlay:circle];
        }
    }];
}

#pragma mark - MKMapViewDelegate

-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MKUserLocation class]])
    {
        return nil;
    }
    
    MKPinAnnotationView *annotationView = (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:@"view"];
    annotationView.annotation = annotation;
    
    if (!annotationView) {
        annotationView = [[MKPinAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:@"view"];
    }
    annotationView.canShowCallout = YES;
    UIButton *rightCalloutButton = [UIButton buttonWithType: UIButtonTypeDetailDisclosure];
    annotationView.rightCalloutAccessoryView = rightCalloutButton;
    return annotationView;
    
}


-(void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control
{
    [self performSegueWithIdentifier:@"DetailViewController" sender: view.annotation];
   
}

- (IBAction)handleLongPressedGesture:(UILongPressGestureRecognizer *)sender
{
    if (sender.state == UIGestureRecognizerStateBegan) {
        CGPoint touchPoint = [sender locationInView:self.mapView];
        CLLocationCoordinate2D coordinate = [self.mapView convertPoint:touchPoint toCoordinateFromView:self.mapView];
        MKPointAnnotation *newPoint = [[MKPointAnnotation alloc]init];
        newPoint.coordinate = coordinate;
        newPoint.title = @"New Location";
        
        [self.mapView addAnnotation: newPoint];
    }
    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"DetailViewController"]) {
        if ([sender isKindOfClass:[MKPointAnnotation class]]) {
            MKPointAnnotation *annotation = (MKPointAnnotation *)sender;
            DetailViewController *detailViewController = (DetailViewController *)segue.destinationViewController;
            detailViewController.annotation = annotation;
            __weak typeof(self) weakSelf = self;
            detailViewController.completion = ^(MKCircle *circle){
                [weakSelf.mapView addOverlay:circle];

            };
        }
        
    }
    
}

-(MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id<MKOverlay>)overlay
{
    MKCircleRenderer *renderer = [[MKCircleRenderer alloc]initWithOverlay:overlay];
    renderer.strokeColor = [UIColor blueColor];
    renderer.fillColor = [UIColor redColor];
    renderer.alpha = 0.5;
    
    return renderer;
    
}


- (IBAction)locationButtons:(UIButton *)sender
{
    NSString *locationPointers = [sender currentTitle];
    CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(0.0, 0.0);
    
    if ([locationPointers isEqualToString:@"Space Needle"]) {
        
        coordinate = CLLocationCoordinate2DMake(47.6204 , -122.349348);
        
    } else if([locationPointers isEqualToString:@"Statue of Liberty"]) {
        coordinate = CLLocationCoordinate2DMake(40.689247, -74.044502);
        
    } else if ([locationPointers isEqualToString:@"Grand Canyon"]) {
        coordinate = CLLocationCoordinate2DMake(36.056595, -112.125092);
    }
    
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(coordinate, 500, 500);
    [_mapView setRegion:region animated:TRUE];

}


@end
