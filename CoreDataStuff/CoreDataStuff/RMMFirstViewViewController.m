//
//  RMMFirstViewViewController.m
//  CoreDataStuff
//
//  Created by Ricardo Maqueda on 11/11/13.
//  Copyright (c) 2013 Ricardo Maqueda. All rights reserved.
//

#import "RMMFirstViewViewController.h"
#import "RMMSecondViewController.h"
#import "RMMPerson.h"
#import "RMMDataModel.h"

@interface RMMFirstViewViewController ()

@end

@implementation RMMFirstViewViewController

-(void)viewWillAppear:(BOOL)animated{

    NSManagedObjectContext *context = [[RMMDataModel sharedInstance] managedObjectContext];
    NSLog(@"NSManagedObjectContext en %s: %@",__func__, context);
    NSFetchRequest *req = [[NSFetchRequest alloc] initWithEntityName:[RMMPerson entityName]];
    NSArray *coreDataList = [context executeFetchRequest:req error:nil];
    self.personasCount.text = [NSString stringWithFormat:@"%lu", [coreDataList count]];
    [self performSelector:@selector(testLoadDelayed) withObject:nil afterDelay:5];
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"secondVC"]) {
        //RMMSecondViewController *secondVC = segue.destinationViewController;
        //secondVC.context = self.context;
    }
}

- (void)testLoadDelayed {
    NSLog(@"Grabando desde FirstVC");
    NSManagedObjectContext *context = [[RMMDataModel sharedInstance] managedObjectContext];
    RMMPerson *person = [NSEntityDescription insertNewObjectForEntityForName:[RMMPerson entityName] inManagedObjectContext:context];
    person.firstName = @"Ricardo2";
    person.lastName = @"Maqueda2";
    person.email = @"ricardo.maqueda@molestudio.es";
    [[RMMDataModel sharedInstance] saveWithErrorBlock:^(NSError *error) { NSLog(@"Error al salvar datos"); }];
    [self performSelector:@selector(testLoadDelayed) withObject:nil afterDelay:1];
}

@end
