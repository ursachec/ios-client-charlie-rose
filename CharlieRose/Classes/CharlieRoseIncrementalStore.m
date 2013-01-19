#import "CharlieRoseIncrementalStore.h"
#import "CharlieRoseAPIClient.h"

@implementation CharlieRoseIncrementalStore

+ (void)initialize {
    [NSPersistentStoreCoordinator registerStoreClass:self forStoreType:[self type]];
}

+ (NSString *)type {
    return NSStringFromClass(self);
}

+ (NSManagedObjectModel *)model {
    return [[NSManagedObjectModel alloc] initWithContentsOfURL:[[NSBundle mainBundle] URLForResource:@"CharlieRose" withExtension:@"xcdatamodeld"]];
}

- (id <AFIncrementalStoreHTTPClient>)HTTPClient {
    return [CharlieRoseAPIClient sharedClient];
}


#pragma mark - NSFetchedResultsControllerDelegate



@end