//
//  NSFetchedResultsController+CRAdditions.m
//  CharlieRose
//
//  Created by Claudiu-Vlad Ursache on 09.02.13.
//  Copyright (c) 2013 Claudiu-Vlad Ursache. All rights reserved.
//

#import "NSFetchedResultsController+CRAdditions.h"
#import "MenuViewController+CRConfigurationData.h"

@implementation NSFetchedResultsController (CRAdditions)

+ (NSPredicate*)predicateForTopic:(NSString*)topic {
    NSPredicate *predicate = nil;
    if (NO == [MenuViewController isTopicHomeTopic:topic]) {
        predicate = [NSPredicate predicateWithFormat:@"topics contains[cd] %@", topic];
    }
    return predicate;
}

+ (NSArray*)sortDescriptorsForTopic:(NSString*)topic {
    NSMutableArray *sortDescriptiors = @[].mutableCopy;
    NSSortDescriptor *dateDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"datePublished" ascending:NO selector:@selector(compare:)];
    [sortDescriptiors addObject:dateDescriptor];
    return sortDescriptiors;
}

+ (NSFetchRequest*)fetchRequestWithTopic:(NSString*)topic {
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Show"];
    
    NSPredicate *predicate = [self predicateForTopic:topic];
    if (predicate) {
        [fetchRequest setPredicate:predicate];
    }
    
    fetchRequest.sortDescriptors = [self sortDescriptorsForTopic:topic];
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
