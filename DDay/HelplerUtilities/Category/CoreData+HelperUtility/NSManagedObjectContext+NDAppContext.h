//
//  NSManagedObjectContext+NDAppContext.h
//  NidecDemo
//
//  Created by Inturu, Ramanjaneyulu on 22/10/15.
//  Copyright © 2015 Inturu, Ramanjaneyulu. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface NSManagedObjectContext (NDAppContext)

- (NSArray*)getRecordsWithoutFaultingForTable:(NSString*)tableName withPredicate:(NSPredicate*)predicate;

- (NSArray*)getRecordsWithoutFaultingForTable:(NSString*)tableName;

- (NSArray*)getRecordsWithoutFaultingForTable:(NSString*)tableName withSortDescriptors:(NSArray*)
descriptors;

@end
