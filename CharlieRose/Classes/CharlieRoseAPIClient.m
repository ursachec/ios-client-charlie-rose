#import "CharlieRoseAPIClient.h"
#import "AFJSONRequestOperation.h"
#import "Show.h"

NSString * const kRemoteKeyForTopicHome = @"all";
NSString * const kLocalKeyForTopicHome = @"home";

static NSString * const kCharlieRoseAPIBaseURLString = @"http://api-charlie-rose-show.herokuapp.com/";

//static NSString * const kCharlieRoseAPIBaseURLString = @"http://localhost:5000/";


@implementation CharlieRoseAPIClient

+ (CharlieRoseAPIClient *)sharedClient {
    static CharlieRoseAPIClient *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[CharlieRoseAPIClient alloc] initWithBaseURL:[NSURL URLWithString:kCharlieRoseAPIBaseURLString]];
    });
    
    return _sharedClient;
}

- (id)initWithBaseURL:(NSURL *)url {
    self = [super initWithBaseURL:url];
    if (!self) {
        return nil;
    }
    
    [self registerHTTPOperationClass:[AFJSONRequestOperation class]];
    [self setDefaultHeader:@"Accept" value:@"application/json"];

    
    return self;
}

# pragma mark - url helpers

+ (NSURL*)imageURLForShowId:(NSString*)showId {
	NSString* link = [NSString stringWithFormat:@"%@/images/%@", kCharlieRoseAPIBaseURLString, showId];
	return [NSURL URLWithString:link];
}

+ (NSURL*)videoURLForShowId:(NSString*)showId {
	NSString* link = [NSString stringWithFormat:@"%@/videos/%@", kCharlieRoseAPIBaseURLString, showId];
	return [NSURL URLWithString:link];
}

#pragma mark - functional methods

- (void)getShowsForTopic:(NSString*)topic 
                 success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                 failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    NSString *path = [NSString stringWithFormat:@"shows/topic/%@", topic];
    
    NSMutableURLRequest *request = [self requestWithMethod:@"GET" path:path parameters:nil];
    [request setTimeoutInterval:3];
    AFHTTPRequestOperation *operation = [self HTTPRequestOperationWithRequest:request success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (success) {
            success((AFJSONRequestOperation *)operation, responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure((AFJSONRequestOperation *)operation, error);
        }
    }];
    
    [self enqueueHTTPRequestOperation:operation];
}

- (void)getShowWithID:(NSString*)showID
              success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
              failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    NSString *path = [NSString stringWithFormat:@"shows/%@", showID];
    [self getPath:path parameters:nil success:success failure:failure];
}

- (void)getLastContentUpdateWithSuccess:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    NSString *path = [NSString stringWithFormat:@"last_content_update"];
    [self getPath:path parameters:nil success:success failure:failure];
}

@end
