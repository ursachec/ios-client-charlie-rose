#import "AFIncrementalStore.h"
#import "AFRestClient.h"

@interface CharlieRoseAPIClient : AFRESTClient <AFIncrementalStoreHTTPClient>

+ (CharlieRoseAPIClient *)sharedClient;
+ (NSURL*)imageURLForShowId:(NSString*)showId;
+ (NSURL*)videoURLForShowId:(NSString*)showId;

- (void)getShowsForTopic:(NSString*)topic
                 success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                 failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

@end
