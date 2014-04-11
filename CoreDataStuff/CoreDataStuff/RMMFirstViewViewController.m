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
    NSFetchRequest *req = [[NSFetchRequest alloc] initWithEntityName:[RMMPerson entityName]];
    NSArray *coreDataList = [context executeFetchRequest:req error:nil];
    self.personasCount.text = [NSString stringWithFormat:@"%lu", [coreDataList count]];
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"secondVC"]) {
        RMMSecondViewController *secondVC = segue.destinationViewController;
        //secondVC.context = self.context;
    }
}

@end
