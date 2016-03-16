//
//  Reminder.m
//  LocationReminders
//
//  Created by Lacey Vu on 3/16/16.
//  Copyright © 2016 Lacey Vu. All rights reserved.
//

#import "Reminder.h"
#import <Parse/PFObject+Subclass.h>


@implementation Reminder


@dynamic name, location, radius;

+(void)load
{
    [self registerSubclass];
}

+(NSString *)parseClassName
{
    return @"Reminder";
}



@end
