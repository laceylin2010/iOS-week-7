//
//  Queue.m
//  LocationReminders
//
//  Created by Lacey Vu on 3/14/16.
//  Copyright © 2016 Lacey Vu. All rights reserved.
//

#import "Queue.h"
#import "ListItem.h"

@implementation Queue

-(instancetype)init
{
    self = [super init];
    if (self) {
        _head = [[ListItem alloc]init];
        
    }
    return self;
}

-(void)add:(NSString *)key;
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

-(void)removeFirstIn;
{
    if (self.head.key == nil) { //check list is not empty
        NSLog(@"This list is empty");
        return;
    }
    
    ListItem *nextItem = self.head.next; //can either be nil or the new head. want to check if this is nil
    
    if (nextItem == nil) {
        self.head.key = nil; //head is only item and set it to nil
        NSLog(@"The list is NOW empty");
        return;
    }
    

    nextItem.previous = nil; //kills the previous pointer
    self.head = nextItem; //current head loses connection to the list itself(queue)
    NSLog(@"The new head is: %@", self.head.key);
    
}

-(BOOL)isEmpty
{
    if (self.head.key == nil) {
        return YES;
    }
    return NO;
}

@end
