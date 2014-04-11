//
//  BeersDataModel.h
//  CoreDataBasics
//
//  Created by Ben Scheirman on 4/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface RMMDataModel : NSObject

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

+ (RMMDataModel *)sharedInstance;

//- (NSString *)modelName;
//- (NSString *)pathToModel;
//- (NSString *)storeFilename;
//- (NSString *)pathToLocalStore;
- (void)zapAllData;
- (void)saveWithErrorBlock:(void(^)(NSError *error))errorBlock;


- (void)saveDataInManagedContextUsingBlock:(void (^)(BOOL saved, NSError *error))savedBlock;

- (NSFetchedResultsController *)fetchEntitiesWithClassName:(NSString *)className
                                           sortDescriptors:(NSArray *)sortDescriptors
                                        sectionNameKeyPath:(NSString *)sectionNameKeypath
                                                 predicate:(NSPredicate *)predicate;

- (id)createEntityWithClassName:(NSString *)className attributesDictionary:(NSDictionary *)attributesDictionary;
- (void)deleteEntity:(NSManagedObject *)entity;
- (BOOL)uniqueAttributeForClassName:(NSString *)className attributeName:(NSString *)attributeName attributeValue:(id)attributeValue;


@end