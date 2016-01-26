//
//  NSString+Ranges.h
//  
//
//  Created by Kasper Welner on 19/06/11.
//  Copyright 2011 Kasper Welner. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSString (NSString_Ranges)

- (NSRange) rangeFromString:(NSString *)firstString toString:(NSString *)lastString inRange:(NSRange)searchRange;
- (NSRange) rangeFromString:(NSString *)firstString toString:(NSString *)lastString;

@end
