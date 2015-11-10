//
//  NSObject+HelperUtility.m
//  MobileMerchant
//
//  Created by Madan, Bunty on 08/04/15.
//  Copyright (c) 2015 Accenture. All rights reserved.
//

#import "NSObject+HelperUtility.h"
#import "NDConstant.h"

@implementation NSObject (HelperUtility)

#pragma -- App Basic Information
-(NSString *)getAdditionalVersionInformationString {
    NSDictionary *info = [[NSBundle mainBundle] infoDictionary];
#ifdef DEVELOPMENT
    NSString *buildDateTime = [info objectForKey:@"BuildDateTime"];
    NSString *gitInfo = [info objectForKey:@"GitInfo"];
    NSString *text = [NSString stringWithFormat: @"%@ git:%@", buildDateTime, gitInfo];
#else
    NSString *text = @"";
#endif
    return text;
}

-(NSString *)createVersionString   {
    NSDictionary *info = [[NSBundle mainBundle] infoDictionary];
    NSString *version = [info objectForKey:@"CFBundleShortVersionString"];
#ifdef DEVELOPMENT
    NSNumber *buildNumber = [info objectForKey:@"CFBundleVersion"];
    NSString *text = [NSString stringWithFormat: @"v%@ %@", version, buildNumber];
#else
    NSString *text = [NSString stringWithFormat: @"v%@", version];
#endif
    return text;
}

-(NSDate*)dateFromDateString:(NSString*)dateString    {
    if (dateString.length)  {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:SERVER_DATE_FORMAT];
        NSDate *date = [formatter dateFromString:dateString];
        return date;
    }   else    {
        return nil;
    }
}

-(NSArray *)sortDatesArray:(NSArray *)array order:(BOOL)isAscending forKey:(NSString *)key   {
    NSArray *sortedArray = [array sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        NSComparisonResult result = [[self dateFromDateString:[obj1 valueForKey:key]] compare:[self dateFromDateString:[obj2 valueForKey:key]]];
        if (result == NSOrderedAscending) {
            return isAscending ? YES : NO;
        } else if (result == NSOrderedDescending) {
            return isAscending ? NO : YES;
        }
        return NO;
    }];
    return sortedArray;
}


-(NSString *)stringFromDateStringWithYearMonthDay {
    NSString *string  = (NSString *)self;
    NSDate *date = [self dateFromDateString:string];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd"];
    return [dateFormat stringFromDate:date];
}

-(NSUInteger)getDaysCountBetweenCurrentDateFrom:(NSDate *)startingDate  {
    return 2;
}

-(BOOL)isEmptyString    {
    NSString *string = (NSString *)self;
    if ([string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length == 0 || string == nil || string == NULL) {
        return YES;
    }
    return NO;
}

-(NSString *)getLowerCaseStringWithWithOutWhiteSpace    {
    NSString *string = (NSString *)self;
    return [[string lowercaseString] stringByReplacingOccurrencesOfString:@" " withString:@""];
}

-(NSString *)getTitleForDictionary:(NSString *) title {
    //currently we are getting single response in multiple deletion once integration with web api only need to uncomment that line.
    NSDictionary *dictionary = (NSDictionary *)self;
    NSMutableString *mutableString = [NSMutableString string];
    NSArray *items = [dictionary objectForKey:@"ExtOfProduct"];
    for (NSDictionary *item in items) {
        //[mutableString appendFormat:@"%@ ",[item objectForKey:@"productid"]];
        if ([items lastObject] == item) {
            [mutableString appendFormat:@"%@",[item objectForKey:@"comments"]];
        }
    }
    return mutableString;
}

@end