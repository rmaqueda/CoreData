//
//  RMMAppDelegate.m
//  CoreDataStuff
//
//  Created by Ricardo Maqueda on 11/11/13.
//  Copyright (c) 2013 Ricardo Maqueda. All rights reserved.
//

#import "RMMAppDelegate.h"
#import "RMMFirstViewViewController.h"
#import "RMMCoreDataStack.h"
#import "RMMPerson.h"
#import "RMMDataModel.h"

@implementation RMMAppDelegate



- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
//    self.model = [RMMCoreDataStack coreDataStackWithModelName:@"CoreDataStuff"];
//    [self loadInittialData];
//    
//    // Override point for customization after application launch.
//    UINavigationController *navigationController = (UINavigationController *)self.window.rootViewController;
//    RMMFirstViewViewController *firstVC = (RMMFirstViewViewController *)navigationController.topViewController;
//    firstVC.context = self.model.context;

    
    NSManagedObjectContext *context = [[RMMDataModel sharedInstance] managedObjectContext];
    if (context) {
        NSLog(@"NSManagedObjectContext en %s: %@",__func__, context);
        //[self loadInittialData];
        [self performSelector:@selector(testLoadDelayed) withObject:nil afterDelay:5];
    }
    
    return YES;
}
							

- (void)loadInittialData {

    NSManagedObjectContext *context = [[RMMDataModel sharedInstance] managedObjectContext];

    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"dataSet" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    NSError* error = nil;
    NSArray *jsonList = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    NSLog(@"Elemento en JSON: %lu", [jsonList count]);
    
    NSArray *firstNames = [[jsonList valueForKey:@"firstName"] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    
    NSFetchRequest *req = [[NSFetchRequest alloc] initWithEntityName:[RMMPerson entityName]];
    [req setPredicate: [NSPredicate predicateWithFormat:@"(firstName IN %@)", firstNames]];
    [req setSortDescriptors:@[[[NSSortDescriptor alloc] initWithKey: @"firstName" ascending:YES]]];
    NSArray *coreDataList = [context executeFetchRequest:req error:nil];
    NSLog(@" Elemento en CoreData: %lu", [coreDataList count]);

    if ([coreDataList count] < [jsonList count] ) {
        //[[RMMDataModel sharedInstance] zapAllData];
        [jsonList enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            RMMPerson *person = [NSEntityDescription insertNewObjectForEntityForName:[RMMPerson entityName] inManagedObjectContext:context];
            person.firstName = [obj objectForKey:@"firstName"];
            person.lastName = [obj objectForKey:@"lastName"];
            person.email = [obj objectForKey:@"email"];
        }];
        
        [[RMMDataModel sharedInstance] saveWithErrorBlock:^(NSError *error) {
            NSLog(@"Error al salvar datos");
        }];
        
    } else {
        
    }
}


- (void)testLoadDelayed {
    NSLog(@"Grabando desde AppDelegate");
    NSManagedObjectContext *context = [[RMMDataModel sharedInstance] managedObjectContext];
    RMMPerson *person = [NSEntityDescription insertNewObjectForEntityForName:[RMMPerson entityName] inManagedObjectContext:context];
    person.firstName = @"Ricardo";
    person.lastName = @"Maqueda";
    person.email = @"ricardo.maqueda@molestudio.es";
    [[RMMDataModel sharedInstance] saveWithErrorBlock:^(NSError *error) { NSLog(@"Error al salvar datos"); }];
    [self performSelector:@selector(testLoadDelayed) withObject:nil afterDelay:1];
}

@end
