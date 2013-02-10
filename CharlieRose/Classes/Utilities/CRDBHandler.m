//
//  CRDBHandler.m
//  CharlieRose
//
//  Created by Claudiu-Vlad Ursache on 10.02.13.
//  Copyright (c) 2013 Claudiu-Vlad Ursache. All rights reserved.
//

#import "CRDBHandler.h"

#import "Show.h"

@interface CRDBHandler ()

@property (nonatomic, strong) Show* show;

@property (nonatomic, strong, readwrite) NSDateFormatter *articlesDateFormatter;
@property (nonatomic, strong, readwrite) NSNumberFormatter *numberFormatter;
@property (nonatomic, strong, readwrite) NSEntityDescription *showEntityDescription;

@end

@implementation CRDBHandler

+ (CRDBHandler *)sharedDBHandler {
    static CRDBHandler *_sharedDBHandler = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedDBHandler = [[CRDBHandler alloc] init];
    });
    
    return _sharedDBHandler;
}

- (void)importShowFromDictionary:(NSDictionary*)dictionary {    
    self.show = nil;
    self.show.headline = dictionary[@"headline"];
    self.show.guests = dictionary[@"guests"];
    self.show.headline = dictionary[@"headline"];
    self.show.topics = dictionary[@"topics"];
    self.show.clipDescription = dictionary[@"video_description"];
    self.show.keywords = dictionary[@"keywords"];
    self.show.showID = dictionary[@"show_id_string"];
    self.show.imageURL = dictionary[@"image_url"];
    self.show.datePublished = [NSDate date];
    
#warning TODO: set right date
    //dictionary[@"date_published"]
    
}

- (void)importShowsArray:(NSArray*)shows
                forTopic:(NSString*)topic
                 success:(void (^)(void))success
                 failure:(void (^)(NSError* error))failure {
    
    // create new managedObjectContext
    NSManagedObjectContext *managedObjectContext = [[NSManagedObjectContext alloc] init];
    [managedObjectContext setPersistentStoreCoordinator:[self.insertionContext persistentStoreCoordinator]];    

    // save shows to DB
    NSError* error = nil;
    for (NSDictionary* show in shows) {
        [self importShowFromDictionary:show];
    }
    [self.insertionContext save:&error];
    
    // call the relevat block
    if (error != nil) {
        failure(error);
    } else {
        success();
    }    
}

#pragma mark - Private methods

- (NSURL *)applicationDocumentsDirectory {
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

#pragma mark - CoreData stuff

- (NSManagedObjectContext *)insertionContext {
    if (_insertionContext == nil) {
        _insertionContext = [[NSManagedObjectContext alloc] init];
        [_insertionContext setPersistentStoreCoordinator:self.persistentStoreCoordinator];
    }
    return _insertionContext;
}

- (NSEntityDescription *)showEntityDescription {
    if (_showEntityDescription == nil) {
        _showEntityDescription = [NSEntityDescription entityForName:@"Show" inManagedObjectContext:self.insertionContext];
    }
    return _showEntityDescription;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    NSURL *storeUrl = [[self applicationDocumentsDirectory] URLByAppendingPathComponent: @"store.sqlite"];
    
    NSError *error = nil;
    NSDictionary *options = [NSDictionary dictionaryWithObjectsAndKeys:
    						 [NSNumber numberWithBool:YES], NSMigratePersistentStoresAutomaticallyOption,
    						 [NSNumber numberWithBool:YES], NSInferMappingModelAutomaticallyOption, nil];
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:self.managedObjectModel];
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeUrl options:options error:&error]) {
        // Handle error
    }
    
    return _persistentStoreCoordinator;
}

- (NSManagedObjectModel *)managedObjectModel {
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"CRModel" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (Show *)show {
    if (_show == nil) {
        _show = [[Show alloc] initWithEntity:self.showEntityDescription insertIntoManagedObjectContext:self.insertionContext];
    }
    return _show;
}

#pragma mark - Core Data

- (void)saveContext {
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.insertionContext;
    if (managedObjectContext) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

@end
