//
//  NSDictionary+MMDictionary.h
//  MobileMerchant
//
//  Created by Samuel Kore, Joel on 7/2/15.
//  Copyright (c) 2015 Accenture. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (MMDictionary)

+(NSString*)validatedString:(id)value;

+(NSString*)validateNullAddPlaceholder:(id)value;

-(NSString*)getStringValueForKey:(NSString*)key;

@end
