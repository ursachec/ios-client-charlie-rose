//
//  CRRemoteManagedObject.m
//  CharlieRose
//
//  Created by Claudiu-Vlad Ursache on 09.02.13.
//  Copyright (c) 2013 Claudiu-Vlad Ursache. All rights reserved.
//

#import "CRRemoteManagedObject.h"

@implementation CRRemoteManagedObject

- (void)create {
	[self createWithSuccess:nil failure:nil];
}


- (void)createWithSuccess:(void(^)(void))success failure:(void(^)(AFJSONRequestOperation *remoteOperation, NSError *error))failure {
	// Subclasses must override this method
}


- (void)update {
	[self updateWithSuccess:nil failure:nil];
}


- (void)updateWithSuccess:(void(^)(void))success failure:(void(^)(AFJSONRequestOperation *remoteOperation, NSError *error))failure {
	// Subclasses must override this method
}


+ (void)sortWithObjects:(NSArray *)objects {
	[self sortWithObjects:objects success:nil failure:nil];
}


+ (void)sortWithObjects:(NSArray *)objects success:(void(^)(void))success failure:(void(^)(AFJSONRequestOperation *remoteOperation, NSError *error))failure {
	// Subclasses must override this method
}

@end
