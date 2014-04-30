//
//  RMMSecondViewController.m
//  CoreDataStuff
//
//  Created by Ricardo Maqueda on 11/11/13.
//  Copyright (c) 2013 Ricardo Maqueda. All rights reserved.
//

#import "RMMSecondViewController.h"
#import "RMMPerson.h"
#import "RMMCoreDataStack.h"
#import "RMMDataModel.h"


@interface RMMSecondViewController ()

@end

@implementation RMMSecondViewController

-(void)viewWillAppear:(BOOL)animated{
    
    NSManagedObjectContext *context = [[RMMDataModel sharedInstance] managedObjectContext];
    NSLog(@"NSManagedObjectContext en %s: %@",__func__, context);
    NSFetchRequest *req = [[NSFetchRequest alloc] initWithEntityName:[RMMPerson entityName]];
    NSArray *coreDataList = [context executeFetchRequest:req error:nil];
    self.personasCount.text = [NSString stringWithFormat:@"%lu", [coreDataList count]];
    [self performSelector:@selector(testLoadDelayed) withObject:nil afterDelay:10];
}

- (void)testLoadDelayed {
    NSLog(@"Grabando desde SecondVC");
    NSManagedObjectContext *context = [[RMMDataModel sharedInstance] managedObjectContext];
    RMMPerson *person = [NSEntityDescription insertNewObjectForEntityForName:[RMMPerson entityName] inManagedObjectContext:context];
    person.firstName = @"Ricardo3";
    person.lastName = @"Maqueda3";
    person.email = @"ricardo.maqueda@molestudio.es";
    [[RMMDataModel sharedInstance] saveWithErrorBlock:^(NSError *error) { NSLog(@"Error al salvar datos"); }];
    [self performSelector:@selector(testLoadDelayed) withObject:nil afterDelay:1];
}




@end
