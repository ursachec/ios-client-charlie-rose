//
//  NSError+CRAdditions.m
//  CharlieRose
//
//  Created by Claudiu-Vlad Ursache on 10.02.13.
//  Copyright (c) 2013 Claudiu-Vlad Ursache. All rights reserved.
//

#import "NSError+CRAdditions.h"

@implementation NSError (CRAdditions)

- (BOOL)isNetworkingError {
    return [self.domain isEqualToString:NSURLErrorDomain];
}

- (BOOL)isCoreDataError {
    NSLog(@"coredata self.code: %d", self.code);
    return YES;
}

@end
