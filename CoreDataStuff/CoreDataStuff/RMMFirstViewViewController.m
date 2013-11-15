//
//  RMMFirstViewViewController.m
//  CoreDataStuff
//
//  Created by Ricardo Maqueda on 11/11/13.
//  Copyright (c) 2013 Ricardo Maqueda. All rights reserved.
//

#import "RMMFirstViewViewController.h"
#import "RMMAppDelegate.h"
#import "RMMSecondViewController.h"

@interface RMMFirstViewViewController ()

@end

@implementation RMMFirstViewViewController
//@synthesize nameText;
@synthesize managedObjectContext;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    NSManagedObject *name = [NSEntityDescription insertNewObjectForEntityForName:@"Event" inManagedObjectContext:self.managedObjectContext];
    [name setValue:@"ppp" forKey:name];

}


- (NSFetchedResultsController *)fetchedResultsController
{
    if (_fetchedResultsController != nil) {
        return _fetchedResultsController;
    }
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    // Edit the entity name as appropriate.
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Event" inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    // Set the batch size to a suitable number.
    //[fetchRequest setFetchBatchSize:20];
    
    // Edit the sort key as appropriate.
//    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"timeStamp" ascending:NO];
//    NSArray *sortDescriptors = @[sortDescriptor];
//    
//    [fetchRequest setSortDescriptors:sortDescriptors];
    
    // Edit the section name key path and cache name if appropriate.
    // nil for section name key path means "no sections".
//    NSFetchedResultsController *aFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:self.managedObjectContext sectionNameKeyPath:nil cacheName:@"Master"];
//    //aFetchedResultsController.delegate = self;
//    self.fetchedResultsController = aFetchedResultsController;
    
//	NSError *error = nil;
//	if (![self.fetchedResultsController performFetch:&error]) {
//        // Replace this implementation with code to handle the error appropriately.
//        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//	    NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
//	    abort();
//	}
    
    return _fetchedResultsController;
}

- (NSManagedObjectContext *)managedObjectContext {
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    return context;
}


@end
