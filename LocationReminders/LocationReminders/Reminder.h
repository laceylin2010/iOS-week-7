//
//  Reminder.h
//  LocationReminders
//
//  Created by Lacey Vu on 3/16/16.
//  Copyright © 2016 Lacey Vu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>

@interface Reminder : PFObject<PFSubclassing>

@property (strong, nonatomic)NSString *name;
@property (strong, nonatomic)PFGeoPoint *location;
@property (strong, nonatomic)NSNumber *radius;

@end
