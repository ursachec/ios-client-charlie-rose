#import "CharlieRoseAPIClient.h"
#import "AFJSONRequestOperation.h"
#import "CRShow.h"

static NSString * const kCharlieRoseAPIBaseURLString = @"http://192.168.178.25:5000";

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

//
- (void)getShowsForTopic:(NSString*)topic 
                 success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                 failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    

    NSString *path = [NSString stringWithFormat:@"shows/topic/%@", topic];
    [self getPath:path parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        
        __weak NSManagedObjectContext *context = [CRShow mainQueueContext];
        [context performBlockAndWait:^{
            for (NSDictionary *showDictionary in responseObject) {
                CRShow *task = [CRShow objectWithDictionary:showDictionary];
            }
            [context save:nil];
        }];
        
        if (success) {
            success((AFJSONRequestOperation *)operation, responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure((AFJSONRequestOperation *)operation, error);
        }
    }];
    
}


//
- (void)getShowWithID:(NSString*)showID
              success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
              failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    NSString *path = [NSString stringWithFormat:@"shows/%@", showID];
    [self getPath:path parameters:nil success:success failure:failure];
}

//
- (void)getLastContentUpdateWithSuccess:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    NSString *path = [NSString stringWithFormat:@"last_content_update"];
    [self getPath:path parameters:nil success:success failure:failure];
}


@end
