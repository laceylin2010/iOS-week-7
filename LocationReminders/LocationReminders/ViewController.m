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
#import <Parse/Parse.h>
#import <ParseUI/ParseUI.h>

@import MapKit;
@import CoreLocation;



@interface ViewController () <MKMapViewDelegate, PFLogInViewControllerDelegate, PFSignUpViewControllerDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) CLLocationManager* locationManager;


@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self login];
    [self setupMapView];
    [self.mapView setDelegate:self];
    

}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[[LocationController sharedController]delegate]self];
    [[[LocationController sharedController]locationManager]startUpdatingLocation];
    
      
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
    [self performSegueWithIdentifier:@"DetailViewController" sender: view];
   
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
        if ([sender isKindOfClass:[MKAnnotationView class]]) {
            MKAnnotationView *annotationView = (MKAnnotationView *)sender;
            DetailViewController *detailViewController = (DetailViewController *)segue.destinationViewController;
            detailViewController.annotationTitle = annotationView.annotation.title;
            detailViewController.coordinate = annotationView.annotation.coordinate;
            detailViewController.completion = ^(MKCircle *circle){
                [self.mapView addOverlay:circle];

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


@end
