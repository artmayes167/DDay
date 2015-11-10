//
//  NSDictionary+MMDictionary.m
//  MobileMerchant
//
//  Created by Samuel Kore, Joel on 7/2/15.
//  Copyright (c) 2015 Accenture. All rights reserved.
//

#import "NSDictionary+MMDictionary.h"

@implementation NSDictionary (MMDictionary)

+(NSString*)validatedString:(id)value{
    
    NSString *values ;
    if([value isKindOfClass:[NSNumber class]])
        values = [value stringValue];
    else {
        values = value ? value : @"";
    }
    return values;
    
}

+(NSString*)validateNullAddPlaceholder:(id)value{
    
    value = value ? value : @"N/A";
    
    return value;
}

-(NSString*)getStringValueForKey:(NSString*)key
{
    if([[self allKeys] containsObject:key]&& [self objectForKey:key] != [NSNull null])
    {
        return [self objectForKey:key];
    }
    
    return @"";
}

@end
