//
//  DetailViewController.h
//  LocationReminders
//
//  Created by Lacey Vu on 3/15/16.
//  Copyright © 2016 Lacey Vu. All rights reserved.
//

#import <UIKit/UIKit.h>
@import MapKit;

typedef void(^detailViewControllerCompletion)(MKCircle *circle);

@interface DetailViewController : UIViewController

@property (copy, nonatomic)NSString *annotationTitle;
@property (nonatomic) CLLocationCoordinate2D coordinate;
@property (copy, nonatomic) detailViewControllerCompletion completion;

@end
