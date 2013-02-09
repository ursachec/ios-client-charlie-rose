//
//  CRRemoteManagedObject.h
//  CharlieRose
//
//  Created by Claudiu-Vlad Ursache on 09.02.13.
//  Copyright (c) 2013 Claudiu-Vlad Ursache. All rights reserved.
//

#import "SSRemoteManagedObject.h"

#import "SSDataKit.h"


@class AFJSONRequestOperation;

@interface CRRemoteManagedObject : SSRemoteManagedObject

- (void)create;
- (void)createWithSuccess:(void(^)(void))success failure:(void(^)(AFJSONRequestOperation *remoteOperation, NSError *error))failure;

- (void)update;
- (void)updateWithSuccess:(void(^)(void))success failure:(void(^)(AFJSONRequestOperation *remoteOperation, NSError *error))failure;

+ (void)sortWithObjects:(NSArray *)objects;
+ (void)sortWithObjects:(NSArray *)objects success:(void(^)(void))success failure:(void(^)(AFJSONRequestOperation *remoteOperation, NSError *error))failure;

@end
