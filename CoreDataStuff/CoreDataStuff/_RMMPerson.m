// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to RMMPerson.m instead.

#import "_RMMPerson.h"

const struct RMMPersonAttributes RMMPersonAttributes = {
	.email = @"email",
	.firstName = @"firstName",
	.lastName = @"lastName",
	.lastUpdate = @"lastUpdate",
};

const struct RMMPersonRelationships RMMPersonRelationships = {
};

const struct RMMPersonFetchedProperties RMMPersonFetchedProperties = {
};

@implementation RMMPersonID
@end

@implementation _RMMPerson

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Person" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"Person";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Person" inManagedObjectContext:moc_];
}

- (RMMPersonID*)objectID {
	return (RMMPersonID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	

	return keyPaths;
}




@dynamic email;






@dynamic firstName;






@dynamic lastName;






@dynamic lastUpdate;











@end
