//
//  NSString+Ranges.m
//  
//
//  Created by Kasper Welner on 19/06/11.
//  Copyright 2011 Kasper Welner. All rights reserved.
//

#import "NSString+Ranges.h"


@implementation NSString (NSString_Ranges)

- (NSRange) rangeFromString:(NSString *)firstString toString:(NSString *)lastString inRange:(NSRange)searchRange
{
    if (NSMaxRange(searchRange) > [self length])
        return NSMakeRange(0, 0);
    
    NSRange range1 = [self rangeOfString:firstString options:NSCaseInsensitiveSearch range:searchRange];
    
    if (range1.length == 0) return range1;
    
    NSUInteger oldSearchLoc = searchRange.location;
    searchRange.location = NSMaxRange(range1);
    searchRange.length = searchRange.length + (oldSearchLoc - searchRange.location);
    
    
    if (searchRange.length == 0)
        return NSMakeRange(0, 0);
    
    
    NSLog(@"range1.length: %lu, range1.location: %lu, search loc: %lu, search length: %lu string length: %lu", (unsigned long)range1.length, (unsigned long)range1.location,  (unsigned long)searchRange.location, (unsigned long)searchRange.length, (unsigned long)[self length]);
    
    NSRange range2 = [self rangeOfString:lastString options:NSCaseInsensitiveSearch range:searchRange];
    
    if (range2.length == 0) return range1;
    
    
    while (1) {
        NSRange nestedSearchRange = NSMakeRange(range1.location + range1.length, (range2.location - range1.location) - range1.length);
        NSLog(@"range1: %lu.%lu, range2: %lu.%lu, searchRange: %lu.%lu", (unsigned long)range1.location, (unsigned long)range1.length, (unsigned long)range2.location, (unsigned long)range2.length, (unsigned long)nestedSearchRange.location, (unsigned long)nestedSearchRange.length);
        NSRange nestedRange = [self rangeOfString:firstString options:NSCaseInsensitiveSearch range:nestedSearchRange];
        
        if (nestedRange.length > 0)
            range1 = nestedRange;
        else
            break;
    }
    
    return NSMakeRange(range1.location, range2.location - range1.location + range2.length);
}

- (NSRange) rangeFromString:(NSString *)firstString toString:(NSString *)lastString
{
    return [self rangeFromString:firstString toString:lastString inRange:NSMakeRange(0, [self length])];
}

@end
