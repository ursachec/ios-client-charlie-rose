//
//  CRShow.m
//  CharlieRose
//
//  Created by Claudiu-Vlad Ursache on 09.02.13.
//  Copyright (c) 2013 Claudiu-Vlad Ursache. All rights reserved.
//

#import "CRShow.h"

@implementation CRShow

@dynamic collections;
@dynamic date_published;
@dynamic guests;
@dynamic headline;
@dynamic keywords;
@dynamic show_id;
@dynamic show_id_string;
@dynamic show_url;
@dynamic topics;
@dynamic videoDescription;
@dynamic imageURL;

#pragma mark - SSManagedObject

+ (NSString *)entityName {
	return @"CRShow";
}


+ (NSArray *)defaultSortDescriptors {
	return @[[NSSortDescriptor sortDescriptorWithKey:@"date_published" ascending:YES]];
}

#pragma mark - SSRemoteManagedObject

- (void)unpackDictionary:(NSDictionary *)dictionary {
	[super unpackDictionary:dictionary];
    
    // first set all the strings
    self.collections = dictionary[@"collections"];
    self.guests = dictionary[@"guests"];
    self.headline = dictionary[@"headline"];
    self.imageURL = dictionary[@"image_url"];
    self.keywords = dictionary[@"keywords"];
    self.show_id_string = dictionary[@"show_id_string"];
    self.topics = dictionary[@"topics"];
    self.videoDescription = dictionary[@"video_description"];
    
    // then easy parsable items
    self.date_published = [self.class parseDate:@[@"date_published"]];
}


- (BOOL)shouldUnpackDictionary:(NSDictionary *)dictionary {
	return YES;
}

@end
