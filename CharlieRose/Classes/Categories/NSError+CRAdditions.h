//
//  NSError+CRAdditions.h
//  CharlieRose
//
//  Created by Claudiu-Vlad Ursache on 10.02.13.
//  Copyright (c) 2013 Claudiu-Vlad Ursache. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSError (CRAdditions)

- (BOOL)isNetworkingError;
- (BOOL)isCoreDataError;

@end
