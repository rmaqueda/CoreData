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

@interface RMMFirstViewViewController ()

@end

@implementation RMMFirstViewViewController

-(void)viewWillAppear:(BOOL)animated{
    
    NSFetchRequest *req = [[NSFetchRequest alloc] initWithEntityName:[RMMPerson entityName]];
    NSArray *coreDataList = [self.context executeFetchRequest:req error:nil];
    NSLog(@" Elemento en CoreData: %lu", [coreDataList count]);

    self.personasCount.text = [NSString stringWithFormat:@"%lu", [coreDataList count]];
}



@end
