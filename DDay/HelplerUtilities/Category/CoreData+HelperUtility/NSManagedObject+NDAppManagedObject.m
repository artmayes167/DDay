//
//  NSManagedObject+NDAppManagedObject.m
//  NidecDemo
//
//  Created by Inturu, Ramanjaneyulu on 22/10/15.
//  Copyright © 2015 Inturu, Ramanjaneyulu. All rights reserved.
//

#import "NSManagedObject+NDAppManagedObject.h"

@implementation NSManagedObject (NDAppManagedObject)

+ (instancetype)createObjectInContext:(NSManagedObjectContext*)context
{
    return [NSEntityDescription insertNewObjectForEntityForName:[self description]
                                         inManagedObjectContext:context];
}

- (NSArray*)getAllRecordsWithBlockRequest:(void (^)(NSFetchRequest *request))request context:(NSManagedObjectContext*)context
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:[self description] inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    request(fetchRequest);
    
    return [context executeFetchRequest:fetchRequest error:nil];
}

- (void)deleteObject
{
    [self.managedObjectContext deleteObject:self];
}

- (void)save
{
    [self.managedObjectContext save:nil];
}

@end
