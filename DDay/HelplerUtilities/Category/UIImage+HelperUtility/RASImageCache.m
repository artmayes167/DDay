//
//  RASImageCache.m
//  FlickrTopPlaces
//
//  Created by Jyrki Hoisko on 5/18/12.
//  Copyright (c) 2012 Accenture. All rights reserved.
//

#import "RASImageCache.h"

#define KMAX_CACHE_SIZE 10000000 // 10 MB image cache

@interface RASImageCache()
@property (nonatomic, strong) NSString* dataPath;
@property (nonatomic) bool initialized;
@end

@implementation RASImageCache

/*!
 Get instance to singleton.
 */
+ (id)getInstance
{
    static RASImageCache *instance = nil;
    static dispatch_once_t onceToken;
    // Thread-safe getter.
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

// This also updates the cache value by moving the accessed item
// to the top of the list to prevent it from being removed from the cache 
// so soon
- (NSString*)cachePathFor:(NSString *)imageId
{
    if (!self.initialized) {
        [self initCache];
    }
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary* dict = [defaults objectForKey:@"INFO_LIST"];

    NSDictionary* info = [dict valueForKey:imageId];
    NSString* filePath = info[@"filePath"];

    // Remove the current ID from the list, if available.
    NSMutableArray* cacheList = [[defaults arrayForKey:@"CACHE_LIST"] mutableCopy];
    // And then move the item to top of the list in Cache. (last to be destroyed)
    if ([cacheList containsObject:imageId]) {
        [cacheList removeObject:imageId];
        [cacheList insertObject:imageId atIndex:0];
    }
    if (filePath) {
        
            //NSLog(@"RASImageCache: found image from cache");
    }
    return filePath;
}

- (void)removeFromCache:(NSString*)fileId
{
    // Get the cache list and info dictionary from User Defaults
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSMutableArray* cacheList = [[defaults arrayForKey:@"CACHE_LIST"] mutableCopy];
    NSMutableDictionary* cacheDict = [[defaults dictionaryForKey:@"INFO_LIST"] mutableCopy];
    [cacheList removeObject:fileId];
    NSDictionary* fileInfo = [cacheDict valueForKey:fileId];
    NSString *filePath = fileInfo[@"filePath"];
    NSFileManager* manager = [NSFileManager defaultManager];
   [manager removeItemAtPath:filePath error:nil];
    [cacheDict removeObjectForKey:fileId];
    // Update User Defaults
    [defaults setObject:cacheList forKey:@"CACHE_LIST"];
    [defaults setObject:cacheDict forKey:@"INFO_LIST"];
    [defaults synchronize];
}

// Add item to cache
// Makes room for the item until it fits.
- (void)addToCache:(NSString*)imageId
        havingData:(NSData *)data
{
    if (!self.initialized) {
        [self initCache];
    }
    
    if (data.length >= KMAX_CACHE_SIZE) {
        NSLog(@"RASImageCache: Imagesize too large for the cache; rejecting");
        return; //Too big item
    }
    
    // Get the cache list and info dictionary from User Defaults
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSMutableArray* cacheList = [[defaults arrayForKey:@"CACHE_LIST"] mutableCopy];
    NSDictionary* infoDictionary = [defaults dictionaryForKey:@"INFO_LIST"];
    
    bool exists = NO;
    
    if (cacheList) {
        // Check if the item exists
        exists = [cacheList containsObject:imageId];
        // Remove the current ID from the list, if available.
        if (exists) {
            [cacheList removeObject:imageId];
            //Then put current photo as first in the list.
            [cacheList insertObject:imageId atIndex:0];
        }
    } else {
        cacheList = [[NSMutableArray alloc] initWithCapacity:1];
    }
    
    if (!exists) {
        if (!infoDictionary) {
            infoDictionary = [[NSDictionary alloc] init];
        }
        // Store the data to cache. Delete items from cache if no room.
        [self makeRoomAndStore:data forPhotoId:imageId usingDictionary:infoDictionary usingIdList:cacheList];
    }
}


// Internal function
+ (long)cacheSizeFor:(NSArray*)list
             foundIn:(NSDictionary*)cacheDict
{
    long currentCacheSize = 0;
    for (NSString* fileId in list) {
        NSDictionary* fileInfo = [cacheDict valueForKey:fileId];
        NSNumber* nsnro = fileInfo[@"length"];
        long size = [nsnro unsignedLongValue];
        currentCacheSize += size;
    }
    return currentCacheSize;
}

// Internal function
- (void)makeRoomAndStore:(NSData*)data
              forPhotoId:(NSString*)newPhotoId
         usingDictionary:(NSDictionary*)dict
             usingIdList:(NSArray*)list
{
    // Delete files (oldest first) from storage using list until there is enough space for the size of the new item.
    NSFileManager* manager = [NSFileManager defaultManager]; 

    NSMutableArray* list2 = [list mutableCopy];
    NSMutableDictionary* dict2 = [dict mutableCopy];
    while ([list2 count] > 0 && [RASImageCache cacheSizeFor:list2 foundIn:dict2] > (KMAX_CACHE_SIZE - data.length)) {
        //Get the last image and its file path
        NSString *fileId = [list2 lastObject];
        NSDictionary *info = [dict2 valueForKey:fileId];
        NSString *filePath = info[@"filePath"];
        NSLog(@"RASImageCache: Removing file of size %ld from cache!", [info[@"length"] longValue]);
        [manager removeItemAtPath:filePath error:nil];
        [list2 removeLastObject];
        [dict2 removeObjectForKey:fileId];
    }
    
    // Then create a new file and store NSData there
    NSString* newFilePath = [self.dataPath stringByAppendingString: [@"/" stringByAppendingString: newPhotoId]];
        //NSLog(@"RASImageCache: Path: %@", newFilePath);
    [data writeToFile:newFilePath atomically:NO];
    
    // Update cache
    [list2 insertObject:newPhotoId atIndex:0];
    NSDictionary *fileInfo = @{@"filePath": newFilePath, @"length": [NSNumber numberWithLong:data.length]};
    [dict2 setObject:fileInfo forKey:newPhotoId];
    
        //NSLog(@"RASImageCache: storing image of size %ld", (unsigned long)data.length);
    
    // Update User Defaults
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:list2 forKey:@"CACHE_LIST"];
    [defaults setObject:dict2 forKey:@"INFO_LIST"];    
    [defaults synchronize];
}

// internal function
- (void)initCache
{
    self.initialized = YES;
    
	/* create path to cache directory inside the application's Documents directory */
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    self.dataPath = [[paths objectAtIndex:0] stringByAppendingPathComponent:@"RASImageCache"];
    
	// check for existence of cache directory
	if ([[NSFileManager defaultManager] fileExistsAtPath:self.dataPath]) {
        // exists, initialization done!
		return;
	}
    
	// create a new cache directory
	if (![[NSFileManager defaultManager] createDirectoryAtPath:self.dataPath
								   withIntermediateDirectories:NO
													attributes:nil
														 error:nil]) {

        NSLog(@"RASImageCache: Error creating Cache folder!!!");
	}
    return;
}


@end
