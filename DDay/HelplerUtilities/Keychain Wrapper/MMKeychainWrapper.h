//
//  MMKeychainWrapper.h
//  MobileMerchant
//
//  Created by Madan, Bunty on 09/04/15.
//  Copyright (c) 2015 Accenture. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Security/Security.h>

@interface MMKeychainWrapper : NSObject

+(BOOL)createKeychainItemForKey:(NSString*)key andValue:(NSString *)value accessGroup:(NSString *)accessGroup;
+(BOOL)updateKeychainItemForKey:(NSString*)key andValue:(NSString *)value accessGroup:(NSString *)accessGroup;
+(NSString *)keychainValueForKey:(NSString *)key accessGroup:(NSString *)accessGroup;
+ (BOOL)deleteKeychainValueForIdentifier:(NSString *)identifier accessGroup:(NSString *)accessGroup;

@end
