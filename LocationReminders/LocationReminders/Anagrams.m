//
//  Anagrams.m
//  LocationReminders
//
//  Created by Lacey Vu on 3/15/16.
//  Copyright © 2016 Lacey Vu. All rights reserved.
//

#import "Anagrams.h"

@implementation Anagrams

-(BOOL)isAnagram:(NSString *)firstString secondString:(NSString *)secondString
{
    if (firstString.length != secondString.length) {
        NSLog(@"String is not an anagram"); //if the two strings being compared dont equal the same length then they arent an anagram
        return NO;

    }
    
    for (int i = 0; i<firstString.length; i++) {
        if ([firstString characterAtIndex: i] == [secondString characterAtIndex:i]) {
            NSLog(@"They are anagrams");
        }
    }
    return YES;
}


@end


//for (int i = 0; i < lengthOfString; i++) { //for each character in the first string
//    int firstStringCount = 0;//starts at 0 for both strings that we are comparing
//    int secondStringCount = 0;
//    for (int ii = 0; ii <lengthOfString; i++) {
//        if ([firstString characterAtIndex: a] == [secondString characterAtIndex:b]) { //if the first characracter in the first string is equal to the second character in the second string
//            firstStringCount++;
//        } if ([firstString characterAtIndex:a] == [secondString characterAtIndex:b]) {
//            secondStringCount++;
//        }
//    }
//}
//

