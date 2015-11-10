//
//  MMKeychainWrapper.m
//  MobileMerchant
//
//  Created by Madan, Bunty on 09/04/15.
//  Copyright (c) 2015 Accenture. All rights reserved.
//

#import "MMKeychainWrapper.h"

@implementation MMKeychainWrapper

static NSString *serviceName = @"com.accenture.rubik";

+ (NSMutableDictionary *)setupkeychainDictionaryForIdentifier:(NSString *)identifier accessGroup:(NSString *)accessGroup{
    // Setup dictionary to access keychain.
    NSMutableDictionary *searchDictionary = [[NSMutableDictionary alloc] init];
    [searchDictionary setObject:(__bridge id)kSecClassGenericPassword forKey:(__bridge id)kSecClass];
        //use the accessgropu for private\public keychain access
    if (accessGroup) {
        searchDictionary[(__bridge id)kSecAttrAccessGroup] = accessGroup;
    }
    NSData *encodedIdentifier = [identifier dataUsingEncoding:NSUTF8StringEncoding];
    [searchDictionary setObject:encodedIdentifier forKey:(__bridge id)kSecAttrGeneric];
    [searchDictionary setObject:encodedIdentifier forKey:(__bridge id)kSecAttrAccount];
    [searchDictionary setObject:serviceName forKey:(__bridge id)kSecAttrService];
    return searchDictionary;
}

+(BOOL)createKeychainItemForKey:(NSString*)key andValue:(NSString *)value accessGroup:(NSString *)accessGroup  {
    NSMutableDictionary *dictionary = [self setupkeychainDictionaryForIdentifier:key accessGroup:accessGroup];
    NSData *valueData = [value dataUsingEncoding:NSUTF8StringEncoding];
    [dictionary setObject:valueData forKey:(__bridge id)kSecValueData];
    
    // Protect the keychain entry so it's only valid when the device is unlocked.
    [dictionary setObject:(__bridge id)kSecAttrAccessibleWhenUnlocked forKey:(__bridge id)kSecAttrAccessible];
    
    // Add.
    OSStatus status = SecItemAdd((__bridge CFDictionaryRef)dictionary, NULL);
    
    // If the addition was successful, return. Otherwise, attempt to update existing key or quit (return NO).
    if (status == errSecSuccess) {
        return YES;
    } else if (status == errSecDuplicateItem){
        return [self updateKeychainItemForKey:key andValue:value accessGroup:accessGroup];
    } else {
        return NO;
    }
}

+(BOOL)updateKeychainItemForKey:(NSString*)key andValue:(NSString *)value accessGroup:(NSString *)accessGroup  {
    NSMutableDictionary *searchDictionary = [self setupkeychainDictionaryForIdentifier:key accessGroup:accessGroup];
    NSMutableDictionary *updateDict = [[NSMutableDictionary alloc] init];
    NSData *valueData = [value dataUsingEncoding:NSUTF8StringEncoding];
    [updateDict setObject:valueData forKey:(__bridge id)kSecValueData];
    OSStatus status = SecItemUpdate ((__bridge CFDictionaryRef)searchDictionary,(__bridge CFDictionaryRef)updateDict);
    if (status == errSecSuccess) {
        return YES;
    } else {
        return NO;
    }
}

+(NSString *)keychainValueForKey:(NSString *)key accessGroup:(NSString *)accessGroup
{
    NSMutableDictionary *searchDictionary = [self setupkeychainDictionaryForIdentifier:key accessGroup:accessGroup];
    // Add search attributes
    [searchDictionary setObject:(__bridge id)kSecMatchLimitOne forKey:(__bridge id)kSecMatchLimit];
    // Add search return types
    [searchDictionary setObject:(id)kCFBooleanTrue forKey:(__bridge id)kSecReturnData];
    NSData *result = nil;
    CFTypeRef resultDict = NULL;
    OSStatus status = SecItemCopyMatching((__bridge CFDictionaryRef)searchDictionary,&resultDict);
    
    if(status == noErr)    {
        result = (__bridge_transfer NSData *)resultDict;
    }   else {
        result = nil;
    }
    
    NSString *kValue = nil;
    if(result)  {
        kValue = [[NSString alloc] initWithData:result
                                       encoding:NSUTF8StringEncoding];
    }
    return kValue;
}


+ (BOOL)deleteKeychainValueForIdentifier:(NSString *)identifier accessGroup:(NSString *)accessGroup
{
    NSMutableDictionary *searchDictionary = [self setupkeychainDictionaryForIdentifier:identifier accessGroup: accessGroup];
    CFDictionaryRef dictionary = (__bridge CFDictionaryRef)searchDictionary;
    
    OSStatus status = SecItemDelete(dictionary);
    
    if (status == errSecSuccess) {
        return YES;
    }
    
    return NO;
}

@end