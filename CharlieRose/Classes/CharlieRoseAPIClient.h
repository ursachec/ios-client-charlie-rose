#import <AFNetworking/AFHTTPClient.h>

@interface CharlieRoseAPIClient : AFHTTPClient

+ (CharlieRoseAPIClient *)sharedClient;
+ (NSURL*)imageURLForShowId:(NSString*)showId;
+ (NSURL*)videoURLForShowId:(NSString*)showId;

- (void)getShowsForTopic:(NSString*)topic
                 success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                 failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

@end
