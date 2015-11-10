//
//  NSManagedObject+NDAppManagedObject.h
//  NidecDemo
//
//  Created by Inturu, Ramanjaneyulu on 22/10/15.
//  Copyright © 2015 Inturu, Ramanjaneyulu. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface NSManagedObject (NDAppManagedObject)

+ (instancetype)createObjectInContext:(NSManagedObjectContext*)context;

- (NSArray*)getAllRecordsWithBlockRequest:(void (^)(NSFetchRequest *request))request context:(NSManagedObjectContext*)context;

- (void)deleteObject;
- (void)save;

@end
