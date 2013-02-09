#import "CharlieRoseAPIClient.h"
#import "AFJSONRequestOperation.h"

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

#pragma mark - AFIncrementalStore

- (id)representationOrArrayOfRepresentationsFromResponseObject:(id)responseObject {
    return responseObject;
}

- (NSDictionary *)attributesForRepresentation:(NSDictionary *)representation 
                                     ofEntity:(NSEntityDescription *)entity 
                                 fromResponse:(NSHTTPURLResponse *)response 
{
	
    NSMutableDictionary *mutablePropertyValues = [[super attributesForRepresentation:representation ofEntity:entity fromResponse:response] mutableCopy];
    
    // Customize the response object to fit the expected attribute keys and values
    
	if ([entity.name isEqualToString:@"Show"]) {
        NSString *guestsString = [representation valueForKey:@"guests"];
        [mutablePropertyValues setValue:guestsString forKey:@"guests"];
		
		NSString *headlineString = [representation valueForKey:@"headline"];
        [mutablePropertyValues setValue:headlineString forKey:@"headline"];
		
		NSString *topicsString = [representation valueForKey:@"topics"];
        [mutablePropertyValues setValue:topicsString forKey:@"topics"];
		
		NSString *videoDescriptionString = [representation valueForKey:@"video_description"];
        [mutablePropertyValues setValue:videoDescriptionString forKey:@"videoDescription"];
		
		NSString *keywordsString = [representation valueForKey:@"keywords"];
        [mutablePropertyValues setValue:keywordsString forKey:@"keywords"];
        
        NSString *showIdString = [representation valueForKey:@"show_id_string"];
        [mutablePropertyValues setValue:showIdString forKey:@"show_id_string"];
        
        NSString *imageURLString = [representation valueForKey:@"image_url"];
        [mutablePropertyValues setValue:imageURLString forKey:@"imageURL"];
        
        
        NSString *dateString = [representation valueForKey:@"date_published"];
        [mutablePropertyValues setValue:AFDateFromISO8601String(dateString) forKey:@"date_published"];
        
		
    }
	
    return mutablePropertyValues;
}

- (BOOL)shouldFetchRemoteAttributeValuesForObjectWithID:(NSManagedObjectID *)objectID
                                 inManagedObjectContext:(NSManagedObjectContext *)context
{
    return [[[objectID entity] name] isEqualToString:@"Show"];
}

- (BOOL)shouldFetchRemoteValuesForRelationship:(NSRelationshipDescription *)relationship
                               forObjectWithID:(NSManagedObjectID *)objectID
                        inManagedObjectContext:(NSManagedObjectContext *)context
{
    return [[[objectID entity] name] isEqualToString:@"Show"];
}

- (NSURLRequest *)requestForFetchRequest:(NSFetchRequest *)fetchRequest
                             withContext:(NSManagedObjectContext *)context
{
    NSMutableURLRequest *mutableURLRequest = nil;
    if ([fetchRequest.entityName isEqualToString:@"Show"]) {
        mutableURLRequest = [self requestWithMethod:@"GET" path:@"shows/topic/all" parameters:nil];
    }
    
    return mutableURLRequest;
}


@end
