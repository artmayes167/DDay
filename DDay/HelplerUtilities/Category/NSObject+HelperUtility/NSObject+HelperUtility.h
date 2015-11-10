//
//  NSObject+HelperUtility.h
//  MobileMerchant
//
//  Created by Madan, Bunty on 08/04/15.
//  Copyright (c) 2015 Accenture. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (HelperUtility)

#pragma -- App Basic Information
-(NSString *)getAdditionalVersionInformationString;
-(NSString *)createVersionString;

#pragma -- NSDate
-(NSDate*)dateFromDateString:(NSString*)dateString;
-(NSUInteger)getDaysCountBetweenCurrentDateFrom:(NSDate *)date;
-(NSString *)stringFromDateStringWithYearMonthDay;
-(NSArray *)sortDatesArray:(NSArray *)array order:(BOOL)isAscending forKey:(NSString *)key;
#pragma --NSString
-(BOOL)isEmptyString;

-(NSString *)getTitleForDictionary:(NSString *) title;
-(NSString *)getLowerCaseStringWithWithOutWhiteSpace;

@end
