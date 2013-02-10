//
//  NSArray+CRAdditions.m
//  CharlieRose
//
//  Created by Claudiu-Vlad Ursache on 10.02.13.
//  Copyright (c) 2013 Claudiu-Vlad Ursache. All rights reserved.
//

#import "NSArray+CRAdditions.h"

@implementation NSArray (CRAdditions)

+ (NSArray*)arrayWithUppercaseStrings:(NSArray*)inArray {
    NSMutableArray* array = [[NSMutableArray alloc] initWithCapacity:inArray.count];
    [inArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if ([obj isKindOfClass:[NSString class]]) {
            [array addObject:[(NSString*)obj uppercaseString]];
        }
    }];
    return array;
}

@end
