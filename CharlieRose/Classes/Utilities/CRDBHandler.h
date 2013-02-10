//
//  CRDBHandler.h
//  CharlieRose
//
//  Created by Claudiu-Vlad Ursache on 10.02.13.
//  Copyright (c) 2013 Claudiu-Vlad Ursache. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CRDBHandler : NSObject

+ (CRDBHandler *)sharedDBHandler;

- (void)importShowsArray:(NSArray*)shows
                forTopic:(NSString*)topic;

@property (nonatomic, strong) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (nonatomic, strong) NSManagedObjectContext *insertionContext;
@property (nonatomic, strong) NSManagedObjectModel *managedObjectModel;

@end

