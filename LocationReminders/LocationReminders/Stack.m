//
//  Stack.m
//  LocationReminders
//
//  Created by Lacey Vu on 3/14/16.
//  Copyright © 2016 Lacey Vu. All rights reserved.
//

#import "Stack.h"

@implementation Stack

-(instancetype)init
{
    self = [super init];
    if (self) {
        _head = [[ListItem alloc]init];
        
    }
    return self;
}


-(void)add:(NSString *)key
{
    if (self.head.key == nil) {
        self.head.key = key;
        NSLog(@"%@", self.head.key);
        
        return;
    }
    
    ListItem *tracker = self.head;
    
    while (tracker.next != nil) {
        NSLog(@"%@", tracker.key);
        tracker = tracker.next;
    }
    
    NSLog(@"%@", tracker.key);
    ListItem *newItem = [[ListItem alloc]init];
    
    newItem.key = key;
    tracker.next = newItem;

    newItem.previous = tracker;
    NSLog(@"%@", newItem.key);
}

-(void)removeLastItem
{
    if (self.head.key == nil) {
        NSLog(@"I am empty!");
        
        return;
    }
    
    ListItem *tracker = self.head;
    
    while (tracker.next != nil) {
        NSLog(@"%@", tracker.key);
        tracker = tracker.next; //if something in front of me I will be going to that item.
    }

    tracker.key = nil;
    tracker.previous.next = nil;
    tracker.previous = nil;
    
}


-(BOOL)isEmpty
{
    if (self.head.key == nil) {
        return YES;
    }
    return NO;
}

@end
