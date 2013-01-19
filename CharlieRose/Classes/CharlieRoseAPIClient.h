#import "AFIncrementalStore.h"
#import "AFRestClient.h"

@interface CharlieRoseAPIClient : AFRESTClient <AFIncrementalStoreHTTPClient>

+ (CharlieRoseAPIClient *)sharedClient;
+ (NSURL*)imageURLForShowId:(NSString*)showId;
+ (NSURL*)videoURLForShowId:(NSString*)showId;

@end
