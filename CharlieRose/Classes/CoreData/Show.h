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
@property (nonatomic, retain) NSDate * datePublished;
@property (nonatomic, retain) NSString * guests;
@property (nonatomic, retain) NSString * headline;
@property (nonatomic, retain) NSString * imageURL;
@property (nonatomic, retain) NSString * keywords;
@property (nonatomic, retain) NSString * showID;
@property (nonatomic, retain) NSString * topics;
@property (nonatomic, retain) NSString * showURL;
@property (nonatomic, retain) NSString * clipDescription;

@end
