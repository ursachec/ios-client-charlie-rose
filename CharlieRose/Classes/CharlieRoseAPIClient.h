#import <AFNetworking/AFHTTPClient.h>

extern NSString * const kRemoteKeyForTopicHome;
extern NSString * const kLocalKeyForTopicHome;

@interface CharlieRoseAPIClient : AFHTTPClient

+ (CharlieRoseAPIClient *)sharedClient;
+ (NSURL*)imageURLForShowId:(NSString*)showId;
+ (NSURL*)videoURLForShowVidlyURL:(NSString*)showVidlyURL;

- (void)getShowsForTopic:(NSString*)topic
                 success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                 failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

@end
