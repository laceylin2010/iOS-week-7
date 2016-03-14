//
//  AppDelegate.m
//  LocationReminders
//
//  Created by Lacey Vu on 3/14/16.
//  Copyright © 2016 Lacey Vu. All rights reserved.
//

#import "AppDelegate.h"
#import <Parse/Parse.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{

    return YES;
}


-(void)setUpParse
{
    ParseClientConfiguration* configuration = [ParseClientConfiguration configurationWithBlock:^(id<ParseMutableClientConfiguration>  _Nonnull configuration) {
        configuration.applicationId = @"fdskfjdskj";
        configuration.clientKey = @"fdsjkaf";
        configuration.server = @"http://localhost:1337/parse";
        
    }];
    [Parse initializeWithConfiguration:configuration];
}


@end
