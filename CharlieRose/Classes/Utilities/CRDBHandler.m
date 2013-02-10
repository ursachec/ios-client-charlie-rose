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
    NSLog(@"importing show: %@", dictionary[@"headline"]);
    
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

- (void)importShowsToDatabaseWithArray:(NSArray*)shows {

    
    NSManagedObjectContext *newManagedObjectContext = [[NSManagedObjectContext alloc] init];
    [newManagedObjectContext setPersistentStoreCoordinator:[self.insertionContext persistentStoreCoordinator]];
    
    
//    [[NSNotificationCenter defaultCenter] addObserver:delegate selector:@selector(importerDidSave:) name:NSManagedObjectContextDidSaveNotification object:newManagedObjectContext];
    NSError *saveError = nil;
    
    
    //enumerate articles
    for (NSDictionary* show in shows) {
        [self importShowFromDictionary:show];
    }
    [self.insertionContext save:&saveError];
    
    NSLog(@"error: %@", saveError);
    
}

- (void)importShowsArray:(NSArray*)shows
                forTopic:(NSString*)topic {

    // do the database import
    [self importShowsToDatabaseWithArray:shows];
    
    // announce to the relevant object that it's done
    
    
    
    
}

-(void)importJSONWithMorePosts:(NSString*)jsonString forCategoryId:(NSString*)categoryId
{
//    LOG_CURRENT_FUNCTION_AND_CLASS()
//    
//    if([delegate respondsToSelector:@selector(didStartImportingData)]){
//        [delegate didStartImportingData];
//    }
//    
//    [[NSNotificationCenter defaultCenter] addObserver:delegate selector:@selector(importerDidSave:) name:NSManagedObjectContextDidSaveNotification object:self.insertionContext];
//    
//    SBJSON *parser = [[SBJSON alloc] init];
//    
//    NSString *json_string = [jsonString copy];
//    NSDictionary *dictionaryFromJSON = [parser objectWithString:json_string error:nil];
//    NSArray *articlesArray = [dictionaryFromJSON objectForKey:kTLArticles];
//    
//    //prepare importing
//    NSManagedObjectContext *newManagedObjectContext = [[NSManagedObjectContext alloc] init];
//    [newManagedObjectContext setPersistentStoreCoordinator:[self.insertionContext persistentStoreCoordinator]];
//    
//    [[NSNotificationCenter defaultCenter] addObserver:delegate selector:@selector(importerDidSave:) name:NSManagedObjectContextDidSaveNotification object:newManagedObjectContext];
//    NSError *saveError = nil;
//    
//    BOOL savedOk = NO;
//    blogEntriesToBeSaved = 0;
//    
//    
//    //----------------------------------------------------
//    //IMPORT ARTICLES
//    DBLog(@"importing articles...");
//    
//    //enumerate articles
//    for (NSDictionary* oneArticle in articlesArray)
//    {
//        [self importOneArticleFromDictionary:oneArticle forceSave:NO];
//    }
//    
//    DBLog(@"saving articles to the insertion context...");
//    savedOk = [self.insertionContext save:&saveError];
//    if (saveError==nil) {
//        DBLog(@"saved articles to the insertion context...");
//    }
//    else {
//        DBLog(@"failed to save articles to insertion context. error: %@", saveError);
//    }
//    
//    DBLog(@"finished importing articles");
//    
//    DBLog(@"self.lastImportDateForMainPageArticle: %@", self.lastImportDateForMainPageArticle);
//    DBLog(@"importJSONWithMorePosts __onecall_didFinishImportingData: savedOk: %@", savedOk ? @"TRUE" : @"FALSE");
//    
//    [[NSNotificationCenter defaultCenter] removeObserver:delegate name:NSManagedObjectContextDidSaveNotification object:self.insertionContext];
//    [[NSNotificationCenter defaultCenter] removeObserver:delegate name:NSManagedObjectContextDidSaveNotification object:newManagedObjectContext];
//    
//    if (savedOk) {
//        
//        //save date for least recent article
//        [[UserDefaultsManager sharedDefautsManager] setDateForLeastRecentArticle:self.currentDateForLeastRecentArticle withCategoryId:categoryId];
//        
//        
//        if([delegate respondsToSelector:@selector(didFinishImportingData)]){
//            [delegate didFinishImportingData];
//        }
//    }
//    else {
//        if([delegate respondsToSelector:@selector(didFailImportingData)]){
//            [delegate didFailImportingData];
//        }
//    }
}

#pragma mark - Application's Documents directory

/**
 Returns the URL to the application's Documents directory.
 */
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

#pragma mark - appropriate getters

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

/**
 Returns the persistent store coordinator for the application.
 If the coordinator doesn't already exist, it is created and the application's store added to it.
 */
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


/**
 Returns the managed object model for the application.
 If the model doesn't already exist, it is created from the application's model.
 */
- (NSManagedObjectModel *)managedObjectModel
{
    if (_managedObjectModel != nil)
    {
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
@end
