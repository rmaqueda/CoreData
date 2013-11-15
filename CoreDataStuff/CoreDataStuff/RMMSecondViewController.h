//
//  RMMSecondViewController.h
//  CoreDataStuff
//
//  Created by Ricardo Maqueda on 11/11/13.
//  Copyright (c) 2013 Ricardo Maqueda. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Event.h"

@interface RMMSecondViewController : UIViewController

@property (strong,nonatomic) NSManagedObjectContext *context;
@property (weak, nonatomic) IBOutlet UITextField *surnameText;
@property (nonatomic, strong) Event *event;

- (IBAction)saveButtom:(id)sender;

@end
