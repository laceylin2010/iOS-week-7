//
//  DetailViewController.m
//  LocationReminders
//
//  Created by Lacey Vu on 3/15/16.
//  Copyright © 2016 Lacey Vu. All rights reserved.
//

#import "DetailViewController.h"




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



@end
