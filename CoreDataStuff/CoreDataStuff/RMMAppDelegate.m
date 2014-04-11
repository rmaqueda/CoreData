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
        NSLog(@"Context is ready!");
        //[self loadInittialData];
    }
    
    [[RMMDataModel sharedInstance] zapAllData];
    
    NSManagedObjectContext *context2 = [[RMMDataModel sharedInstance] managedObjectContext];
    
    
    
    if (context2) {
        NSLog(@"Context is ready!");
        [self loadInittialData];
    }
    
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{

    
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
    } else {
        
    }
    
    [[RMMDataModel sharedInstance] saveWithErrorBlock:^(NSError *error) {
        NSLog(@"Error al salvar datos");
    }];

    NSArray *coreDataList2 = [context executeFetchRequest:req error:nil];
    NSLog(@" Elemento en CoreData: %lu", [coreDataList2 count]);

}

@end
