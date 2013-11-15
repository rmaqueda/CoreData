//
//  RMMFirstViewViewController.h
//  CoreDataStuff
//
//  Created by Ricardo Maqueda on 11/11/13.
//  Copyright (c) 2013 Ricardo Maqueda. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RMMFirstViewViewController : UIViewController

@property (strong,nonatomic) NSManagedObjectContext *context;

@property (weak, nonatomic) IBOutlet UITextField *nameText;

@end
