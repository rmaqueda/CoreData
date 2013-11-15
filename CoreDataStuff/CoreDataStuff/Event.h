//
//  Event.h
//  CoreDataStuff
//
//  Created by Ricardo Maqueda on 15/11/13.
//  Copyright (c) 2013 Ricardo Maqueda. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Event : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * surname;

+(id) eventWithContext:(NSManagedObjectContext *) context;

@end
