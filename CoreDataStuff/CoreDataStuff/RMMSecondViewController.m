//
//  RMMSecondViewController.m
//  CoreDataStuff
//
//  Created by Ricardo Maqueda on 11/11/13.
//  Copyright (c) 2013 Ricardo Maqueda. All rights reserved.
//

#import "RMMSecondViewController.h"
#import "Event.h"

@interface RMMSecondViewController ()

@end

@implementation RMMSecondViewController
@synthesize event;

- (IBAction)saveButtom:(id)sender {
    
    event.surname = self.surnameText.text;
    [self.context save:nil];
    
    NSFetchRequest *fetch = [NSFetchRequest fetchRequestWithEntityName:@"Event"];
    fetch.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES]];
    
    NSArray *results = [self.context executeFetchRequest:fetch error:nil];
    NSLog(@"%@", results);
}


@end
