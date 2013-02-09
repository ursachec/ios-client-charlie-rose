//
//  CRShow.h
//  CharlieRose
//
//  Created by Claudiu-Vlad Ursache on 09.02.13.
//  Copyright (c) 2013 Claudiu-Vlad Ursache. All rights reserved.
//

#import "CRRemoteManagedObject.h"

@interface CRShow : CRRemoteManagedObject

@property (nonatomic, strong) NSString * collections;
@property (nonatomic, strong) NSDate * date_published;
@property (nonatomic, strong) NSString * guests;
@property (nonatomic, strong) NSString * headline;
@property (nonatomic, strong) NSString * keywords;
@property (nonatomic, strong) NSNumber * show_id;
@property (nonatomic, strong) NSString * show_id_string;
@property (nonatomic, strong) NSString * show_url;
@property (nonatomic, strong) NSString * topics;
@property (nonatomic, strong) NSString * videoDescription;
@property (nonatomic, strong) NSString * imageURL;

@end
