//
//  NSFetchedResultsController+CRAdditions.h
//  CharlieRose
//
//  Created by Claudiu-Vlad Ursache on 09.02.13.
//  Copyright (c) 2013 Claudiu-Vlad Ursache. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface NSFetchedResultsController (CRAdditions)

+ (NSFetchedResultsController *)fetchedResultsControllerWithTopic:(NSString*)topic
                                                         delegate:(id<NSFetchedResultsControllerDelegate>)delegate
                                             managedObjectContext:(NSManagedObjectContext*)context;

@end
