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
    NSFetchRequest *req = [[NSFetchRequest alloc] initWithEntityName:[RMMPerson entityName]];
    NSArray *coreDataList = [context executeFetchRequest:req error:nil];
    self.personasCount.text = [NSString stringWithFormat:@"%lu", [coreDataList count]];
}



@end
