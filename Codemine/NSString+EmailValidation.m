//
//  NSString+EmailValidation.m
//  
//
//  Created by Kasper Welner on 12/5/12.
//  Copyright (c) 2012 Nodes. All rights reserved.
//

#import "NSString+EmailValidation.h"

@implementation NSString (EmailValidation)

- (BOOL)isValidEmailAddress {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    
    return [emailTest evaluateWithObject:self];
}

@end
