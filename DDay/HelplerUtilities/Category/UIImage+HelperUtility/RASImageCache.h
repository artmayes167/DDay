//
//  RASImageCache.h
//
//  Created by Jyrki Hoisko on 5/18/12.
//  Copyright (c) 2012 Accenture. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RASImageCache : NSObject

/*!
 @method cachePathFor
 @param fileId
 @return NSString the file path and name or nil
 Returns the filepath to the stored cache version
 of given image. Any time an item is accessed,
 it is moved to last in the cache to be removed.
 If the item is not found in cache, the method returns nil.
 */
- (NSString*)cachePathFor:(NSString*)fileId;

/*!
 @method addToCache:havingData
 @param fileId unique file name or id.
 @param data NSData of the file
 This method shall be called to store given data to cache for given fileId. If there is not
 enough space for the item, the cache will clear old items (the last accessed) until there is enough
 space for the data. A file is automatically created that corresponds to the photoId. This file
 can be queried using cachePath:fileId method.
 */
- (void)addToCache:(NSString*)fileId
        havingData:(NSData*)data;

/*!
 @method removeFromCache
 @param fileId NSString depicting the unique id of the file
*/
- (void)removeFromCache:(NSString*)fileId;

+ (id)getInstance;
@end
