//
//  Show.h
//  CharlieRose
//
//  Created by Claudiu-Vlad Ursache on 10.02.13.
//  Copyright (c) 2013 Claudiu-Vlad Ursache. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Show : NSManagedObject

@property (nonatomic, retain) NSString * collections;
@property (nonatomic, retain) NSDate * date_published;
@property (nonatomic, retain) NSString * guests;
@property (nonatomic, retain) NSString * headline;
@property (nonatomic, retain) NSString * imageURL;
@property (nonatomic, retain) NSString * keywords;
@property (nonatomic, retain) NSString * show_id_string;
@property (nonatomic, retain) NSString * show_url;
@property (nonatomic, retain) NSString * topics;
@property (nonatomic, retain) NSString * videoDescription;
@property (nonatomic, retain) NSNumber * topics_is_technology;
@property (nonatomic, retain) NSNumber * topics_is_sports;
@property (nonatomic, retain) NSNumber * topics_is_science_and_health;
@property (nonatomic, retain) NSNumber * topics_is_music;
@property (nonatomic, retain) NSNumber * topics_is_movies_tv_and_theater;
@property (nonatomic, retain) NSNumber * topics_is_lifestyle;
@property (nonatomic, retain) NSNumber * topics_is_in_memoriam;
@property (nonatomic, retain) NSNumber * topics_is_history;
@property (nonatomic, retain) NSNumber * topics_is_current_affairs;
@property (nonatomic, retain) NSNumber * topics_is_business;
@property (nonatomic, retain) NSNumber * topics_is_books;
@property (nonatomic, retain) NSString * remoteID;

@end
