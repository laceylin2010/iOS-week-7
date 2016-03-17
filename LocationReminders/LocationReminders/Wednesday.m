//
//  Wednesday.m
//  LocationReminders
//
//  Created by Lacey Vu on 3/16/16.
//  Copyright © 2016 Lacey Vu. All rights reserved.
//

#import "Wednesday.h"

@implementation Wednesday


-(int)grabTheNumbers:(NSString *)demoString
{
    int totalValue = 0;
    
    for (int i = 0; i<demoString.length; i++) {
        unichar characters = [demoString characterAtIndex:i];
        if (characters >= 48 && characters <= 57) { //48 is where the computer reads the number 0 and 57 is where it ends.
            totalValue = totalValue + characters - 48;
            NSLog(@"%d",totalValue);
        }

    }
    
    return totalValue;
}

@end
