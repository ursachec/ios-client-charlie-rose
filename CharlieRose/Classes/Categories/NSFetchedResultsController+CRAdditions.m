//
//  NSFetchedResultsController+CRAdditions.m
//  CharlieRose
//
//  Created by Claudiu-Vlad Ursache on 09.02.13.
//  Copyright (c) 2013 Claudiu-Vlad Ursache. All rights reserved.
//

#import "NSFetchedResultsController+CRAdditions.h"

@implementation NSFetchedResultsController (CRAdditions)

+ (NSFetchRequest*)fetchRequestWithTopic:(NSString*)topic {
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Show"];
    
    NSSortDescriptor *dateDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"datePublished" ascending:NO selector:@selector(compare:)];
    
#warning replce this with real topic --> predicate mapping
    if (topic != nil && [topic caseInsensitiveCompare:@"Home"] != NSOrderedSame) {
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"topics contains[cd] %@", @"Technology"];
        [fetchRequest setPredicate:predicate];
    }
    
    fetchRequest.sortDescriptors = @[dateDescriptor];
    fetchRequest.returnsObjectsAsFaults = NO;
    return fetchRequest;
}

+ (NSFetchedResultsController *)fetchedResultsControllerWithTopic:(NSString*)topic
                                                         delegate:(id<NSFetchedResultsControllerDelegate>)delegate
                                             managedObjectContext:(NSManagedObjectContext*)context
{
    NSFetchRequest *fetchRequest = [self fetchRequestWithTopic:topic];
    NSFetchedResultsController *aFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:context sectionNameKeyPath:nil cacheName:nil];
    aFetchedResultsController.delegate = delegate;
    return aFetchedResultsController;
}


@end
