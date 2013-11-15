//
//  Event.m
//  CoreDataStuff
//
//  Created by Ricardo Maqueda on 15/11/13.
//  Copyright (c) 2013 Ricardo Maqueda. All rights reserved.
//

#import "Event.h"


@implementation Event

@dynamic name;
@dynamic surname;

+(id) eventWithContext:(NSManagedObjectContext *) context{
    
    Event *event = [NSEntityDescription insertNewObjectForEntityForName:@"Event" inManagedObjectContext:context];
    return event;
    
}


@end
