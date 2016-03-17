//
//  main.m
//  LocationReminders
//
//  Created by Lacey Vu on 3/14/16.
//  Copyright © 2016 Lacey Vu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "Stack.h"
#import "Queue.h"
#import "Wednesday.h"

int main(int argc, char * argv[]) {
    @autoreleasepool
    {
//        Stack *testing = [[Stack alloc]init];
//        [testing add: @"Hello World"];
//        [testing add: @"Goodnight"];
//        [testing add: @"GoodMorning"];
//        [testing removeLastItem];
//        [testing removeLastItem];
//        [testing removeLastItem];
//        [testing removeLastItem];
//        [testing removeLastItem];
//        Queue *secondTest = [[Queue alloc]init];
//        [secondTest add: @"I Like Coffee"];
//        [secondTest add: @"I Like Tea"];
//        [secondTest add: @"I Like Soda"];
//        [secondTest removeFirstIn];
//        [secondTest removeFirstIn];
//        [secondTest removeFirstIn];
//        [secondTest removeFirstIn];
        Wednesday *thirdTest =[[Wednesday alloc]init];
        [thirdTest grabTheNumbers:@"Hello0123World1239"];
//        [thirdTest grabTheNumbers:@"] add more examples;
        


        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
