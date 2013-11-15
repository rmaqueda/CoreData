//
//  RMMFirstViewViewController.m
//  CoreDataStuff
//
//  Created by Ricardo Maqueda on 11/11/13.
//  Copyright (c) 2013 Ricardo Maqueda. All rights reserved.
//

#import "RMMFirstViewViewController.h"
#import "RMMSecondViewController.h"
#import "RMMAppDelegate.h"
#import "Event.h"

@interface RMMFirstViewViewController ()

@end

@implementation RMMFirstViewViewController

-(void)viewWillAppear:(BOOL)animated{
    
    RMMAppDelegate *appDelegate = (RMMAppDelegate *)[[UIApplication sharedApplication]delegate];
    self.context = [appDelegate managedObjectContext];
    
}



- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender {
    if ([self.nameText.text isEqualToString:@""]) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Name"
                                                        message:@"Name empty is not valid"
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
        return NO;
    }else{
        return YES;
    }
}


- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
   
    Event *event = [NSEntityDescription insertNewObjectForEntityForName:@"Event" inManagedObjectContext:self.context];
    event.name = self.nameText.text;
  
    [[segue destinationViewController] setEvent:event];
    [[segue destinationViewController] setContext:self.context];
    
}


@end
