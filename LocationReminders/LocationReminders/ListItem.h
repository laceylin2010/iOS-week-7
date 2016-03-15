//
//  ListItem.h
//  LocationReminders
//
//  Created by Lacey Vu on 3/14/16.
//  Copyright © 2016 Lacey Vu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ListItem : NSObject

@property NSString *key;
@property ListItem *previous;
@property ListItem *next;


@end
