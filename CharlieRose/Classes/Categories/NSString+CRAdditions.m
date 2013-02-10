//
//  NSString+CRAdditions.m
//  CharlieRose
//
//  Created by Claudiu-Vlad Ursache on 10.02.13.
//  Copyright (c) 2013 Claudiu-Vlad Ursache. All rights reserved.
//

#import "NSString+CRAdditions.h"

@implementation NSString (CRAdditions)

+ (NSString*)titleForTopic:(NSString*)topic {
    
#warning rewrite this using topic -> title mapping
    
    NSString* newTitle = @"";
    if ([topic caseInsensitiveCompare:@"HOME"]==NSOrderedSame) {
        newTitle = @"latest charlie rose shows";
    } else {
        newTitle = [NSString stringWithFormat:@"topic: %@",topic];
    }
    return [newTitle uppercaseString];
}

@end
