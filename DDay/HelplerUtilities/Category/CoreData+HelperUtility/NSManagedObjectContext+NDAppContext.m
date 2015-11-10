//
//  NSManagedObjectContext+NDAppContext.m
//  NidecDemo
//
//  Created by Inturu, Ramanjaneyulu on 22/10/15.
//  Copyright © 2015 Inturu, Ramanjaneyulu. All rights reserved.
//

#import "NSManagedObjectContext+NDAppContext.h"

@implementation NSManagedObjectContext (NDAppContext)

- (NSArray*)getRecordsWithoutFaultingForTable:(NSString*)tableName withPredicate:(NSPredicate*)predicate
{
    @try {
        
        if (!tableName) {
            return nil;
        }
        
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
        
        NSEntityDescription *entity = [NSEntityDescription entityForName:tableName inManagedObjectContext:self];
        [fetchRequest setEntity:entity];
        
        if (predicate) {
            [fetchRequest setPredicate:predicate];
        }
        
        [fetchRequest setReturnsObjectsAsFaults:NO];
        
        return [self executeFetchRequest:fetchRequest error:nil];
    }
    @catch(NSException *e){
        NSLog(@"Exception occured: %@",e);
    }
}

- (NSArray*)getRecordsWithoutFaultingForTable:(NSString*)tableName
{
    @try {
        
        if (!tableName) {
            return nil;
        }
        
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
        
        NSEntityDescription *entityDescription =[NSEntityDescription entityForName:tableName inManagedObjectContext:self];
        [fetchRequest setEntity:entityDescription];
        
        [fetchRequest setReturnsObjectsAsFaults:NO];
        
        return [self executeFetchRequest:fetchRequest error:nil];
    }
    @catch(NSException *e){
        NSLog(@"Exception occured: %@",e);
    }
}

- (NSArray*)getRecordsWithoutFaultingForTable:(NSString*)tableName withSortDescriptors:(NSArray*)descriptors
{
    @try {
        
        if (!tableName) {
            return nil;
        }
        
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
        
        NSEntityDescription *entity = [NSEntityDescription entityForName:tableName inManagedObjectContext:self];
        [fetchRequest setEntity:entity];
        
        if (descriptors) {
            [fetchRequest setSortDescriptors:descriptors];
        }
        
        [fetchRequest setReturnsObjectsAsFaults:NO];
        
        return [self executeFetchRequest:fetchRequest error:nil];
    }
    @catch(NSException *e){
        NSLog(@"Exception occured: %@",e);
    }
}

- (void)deleteRecord:(NSManagedObject*)object
{
    if (!object) {
        return;
    }
    
    [self deleteObject:object];
}

@end
