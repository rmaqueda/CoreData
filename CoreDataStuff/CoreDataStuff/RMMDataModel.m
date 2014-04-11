//
//  BeersDataModel.m
//  CoreDataBasics
//
//  Created by Ben Scheirman on 4/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//
static NSString *sProjectName = @"CoreDataStuff";
#import "RMMDataModel.h"
#import "RMMPerson.h"

@interface RMMDataModel ()

@property (strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@end


@implementation RMMDataModel

@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;
@synthesize managedObjectContext = _managedObjectContext;


+ (RMMDataModel *)sharedInstance {
    static RMMDataModel *_sharedInstance = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        _sharedInstance = [[RMMDataModel alloc] init];
    });
    
    return _sharedInstance;
}

#pragma mark - setup

- (id)init
{
    self = [super init];
    
    if (self) {
        [self setupManagedObjectContext];
    }
    
    return self;
}

//- (NSManagedObjectContext *)managedObjectContext {
//    
//    if (_managedObjectContext == nil) {
//        _managedObjectContext = [[NSManagedObjectContext alloc] init];
//        _managedObjectContext.persistentStoreCoordinator = self.persistentStoreCoordinator;
//    }
//    
//    return _managedObjectContext;
//}

//- (NSManagedObjectModel *)managedObjectModel {
//    if (_managedObjectModel == nil) {
//        _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:[[NSBundle mainBundle] URLForResource:sProjectName withExtension:@"momd"]];
//    }
//    
//    return _managedObjectModel;
//}

- (void)setupManagedObjectContext {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    NSURL *documentDirectoryURL = [fileManager URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask][0];
    
    NSURL *persistentURL = [documentDirectoryURL URLByAppendingPathComponent:[NSString stringWithFormat:@"%@.sqlite", sProjectName]];
    
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:sProjectName withExtension:@"momd"];
    
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:_managedObjectModel];
    
    NSError *error = nil;
    NSPersistentStore *persistentStore = [self.persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType
                                                                                       configuration:nil
                                                                                                 URL:persistentURL
                                                                                             options:nil
                                                                                               error:&error];
    if (persistentStore) {
        _managedObjectContext = [[NSManagedObjectContext alloc] init];
        _managedObjectContext.persistentStoreCoordinator = self.persistentStoreCoordinator;
    } else {
        NSLog(@"ERROR: %@", error.description);
    }
}

- (void)saveDataInManagedContextUsingBlock:(void (^)(BOOL saved, NSError *error))savedBlock
{
    NSError *saveError = nil;
    savedBlock([self.managedObjectContext save:&saveError], saveError);
}

- (NSFetchedResultsController *)fetchEntitiesWithClassName:(NSString *)className
                                           sortDescriptors:(NSArray *)sortDescriptors
                                        sectionNameKeyPath:(NSString *)sectionNameKeypath
                                                 predicate:(NSPredicate *)predicate {
    NSFetchedResultsController *fetchedResultsController;
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:className
                                              inManagedObjectContext:self.managedObjectContext];
    fetchRequest.entity = entity;
    fetchRequest.sortDescriptors = sortDescriptors;
    fetchRequest.predicate = predicate;
    
    fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest
                                                                   managedObjectContext:self.managedObjectContext
                                                                     sectionNameKeyPath:sectionNameKeypath
                                                                              cacheName:nil];
    
    NSError *error = nil;
    BOOL success = [fetchedResultsController performFetch:&error];
    
    if (!success) {
        NSLog(@"fetchManagedObjectsWithClassName ERROR: %@", error.description);
    }
    
    return fetchedResultsController;
}

- (id)createEntityWithClassName:(NSString *)className
           attributesDictionary:(NSDictionary *)attributesDictionary
{
    NSManagedObject *entity = [NSEntityDescription insertNewObjectForEntityForName:className
                                                            inManagedObjectContext:self.managedObjectContext];
    [attributesDictionary enumerateKeysAndObjectsUsingBlock:^(NSString *key, id obj, BOOL *stop) {
        
        [entity setValue:obj forKey:key];
        
    }];
    
    return entity;
}

- (void)deleteEntity:(NSManagedObject *)entity
{
    [self.managedObjectContext deleteObject:entity];
}

- (BOOL)uniqueAttributeForClassName:(NSString *)className
                      attributeName:(NSString *)attributeName
                     attributeValue:(id)attributeValue
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"%K like %@", attributeName, attributeValue];
    NSArray *sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:attributeName ascending:YES]];
    
    NSFetchedResultsController *fetchedResultsController = [self fetchEntitiesWithClassName:className
                                                                            sortDescriptors:sortDescriptors
                                                                         sectionNameKeyPath:nil
                                                                                  predicate:predicate];
    
    return fetchedResultsController.fetchedObjects.count == 0;
}

- (void)zapAllData {
    NSFetchRequest *allPerson = [[NSFetchRequest alloc] init];
    [allPerson setEntity:[NSEntityDescription entityForName:[RMMPerson entityName] inManagedObjectContext:self.managedObjectContext ]];
    [allPerson setIncludesPropertyValues:NO]; //only fetch the managedObjectID
    
    NSError *error = nil;
    NSArray *persons = [self.managedObjectContext executeFetchRequest:allPerson error:&error];
   
    //error handling goes here
    for (NSManagedObject * person in persons) {
        [self.managedObjectContext  deleteObject:person];
    }
    NSError *saveError = nil;
    [self.managedObjectContext  save:&saveError];
}

- (void)saveWithErrorBlock:(void(^)(NSError *error))errorBlock {
    NSError *err = nil;
    // If a context is nil, saving it should also be considered an
    // error, as being nil might be the result of a previous error
    // while creating the db.
    
    if (!_managedObjectContext) {
        err = [NSError errorWithDomain:@"RMMCoreDataStack"
                                  code:1
                              userInfo:@{NSLocalizedDescriptionKey :
                                             @"Attempted to save a nil NSManagedObjectContext. This SimpleCoreDataStack has no context - probably there was an earlier error trying to access the CoreData database file."}];
        errorBlock(err);
        
    }
    else if (_managedObjectContext.hasChanges) {
        if (![_managedObjectContext save:&err]) {
            errorBlock(err);
        }
    }
}

@end
