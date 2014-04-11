// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to RMMPerson.h instead.

#import <CoreData/CoreData.h>


extern const struct RMMPersonAttributes {
	__unsafe_unretained NSString *email;
	__unsafe_unretained NSString *firstName;
	__unsafe_unretained NSString *lastName;
	__unsafe_unretained NSString *lastUpdate;
} RMMPersonAttributes;

extern const struct RMMPersonRelationships {
} RMMPersonRelationships;

extern const struct RMMPersonFetchedProperties {
} RMMPersonFetchedProperties;







@interface RMMPersonID : NSManagedObjectID {}
@end

@interface _RMMPerson : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (RMMPersonID*)objectID;





@property (nonatomic, strong) NSString* email;



//- (BOOL)validateEmail:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* firstName;



//- (BOOL)validateFirstName:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* lastName;



//- (BOOL)validateLastName:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSDate* lastUpdate;



//- (BOOL)validateLastUpdate:(id*)value_ error:(NSError**)error_;






@end

@interface _RMMPerson (CoreDataGeneratedAccessors)

@end

@interface _RMMPerson (CoreDataGeneratedPrimitiveAccessors)


- (NSString*)primitiveEmail;
- (void)setPrimitiveEmail:(NSString*)value;




- (NSString*)primitiveFirstName;
- (void)setPrimitiveFirstName:(NSString*)value;




- (NSString*)primitiveLastName;
- (void)setPrimitiveLastName:(NSString*)value;




- (NSDate*)primitiveLastUpdate;
- (void)setPrimitiveLastUpdate:(NSDate*)value;




@end
