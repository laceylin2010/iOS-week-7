//
//  Queue.h
//  LocationReminders
//
//  Created by Lacey Vu on 3/14/16.
//  Copyright © 2016 Lacey Vu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ListItem.h"

@interface Queue : NSObject

@property ListItem *head;

-(void)add:(NSString *)key;
-(void)removeFirstIn;
-(BOOL)isEmpty;


@end
