//
//  NSString+MMString.h
//  MobileMerchant
//
//  Created by Samuel Kore, Joel on 7/1/15.
//  Copyright (c) 2015 Accenture. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (MMString)

+(NSString*)validatedString:(NSString*)string;
+(NSString*)validatedStringWithoutCapitalization:(NSString*)string;
-(NSString *)getFnAndLnLetters;

@end