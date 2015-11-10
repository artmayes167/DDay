//
//  NSString+MMString.m
//  MobileMerchant
//
//  Created by Samuel Kore, Joel on 7/1/15.
//  Copyright (c) 2015 Accenture. All rights reserved.
//


#import "NSString+MMString.h"

@implementation NSString (MMString)
    
-(NSString *)getFnAndLnLetters   {
    NSString *string = (NSString *)self;
    NSArray *array = [string componentsSeparatedByString:@" "];
    NSString *result = nil;
    if ([array count] == 0) {
        result = @"MM";
    } else if([array count] == 1)   {
        result = [NSString stringWithFormat:@"%@",[[array objectAtIndex:0] substringToIndex:1]];
    } else  {
        result = [NSString stringWithFormat:@"%@%@",[[array objectAtIndex:0] substringToIndex:1],[[array objectAtIndex:1] substringToIndex:1]];
    }
    return result;
}

+ (NSString*)validatedString:(NSString*)string
{
    return [[self validatedStringWithoutCapitalization:string] capitalizedString];
}

+ (NSString*)validatedStringWithoutCapitalization:(NSString*)string
{
    NSString *placeHolder = @"N/A";
    
    if (![string length]) {
        return placeHolder;
    }
    
    NSString *temp = [string stringByTrimmingLeadingWhitespaceAndNewlineCharacters];
    
    return [temp length] ? temp : placeHolder;
}

- (NSString *)stringByTrimmingLeadingWhitespaceAndNewlineCharacters {
    return [self stringByTrimmingLeadingCharactersInSet:
            [NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

#pragma mark - Private

- (NSString *)stringByTrimmingLeadingCharactersInSet:(NSCharacterSet *)characterSet {
    NSRange rangeOfFirstWantedCharacter = [self rangeOfCharacterFromSet:[characterSet invertedSet]];
    if (rangeOfFirstWantedCharacter.location == NSNotFound) {
        return @"";
    }
    return [self substringFromIndex:rangeOfFirstWantedCharacter.location];
}


- (NSString *)stringByTrimmingTrailingCharactersInSet:(NSCharacterSet *)characterSet {
    NSRange rangeOfLastWantedCharacter = [self rangeOfCharacterFromSet:[characterSet invertedSet]
                                                               options:NSBackwardsSearch];
    if (rangeOfLastWantedCharacter.location == NSNotFound) {
        return @"";
    }
    
    return [self substringToIndex:rangeOfLastWantedCharacter.location+1];
}

- (NSString *)stringByTrimmingTrailingWhitespaceAndNewlineCharacters {
    return [self stringByTrimmingTrailingCharactersInSet:
            [NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

@end