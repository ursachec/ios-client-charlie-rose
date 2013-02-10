//
//  MainFeedViewController+CRConfigurationData.m
//  CharlieRose
//
//  Created by Claudiu-Vlad Ursache on 10.02.13.
//  Copyright (c) 2013 Claudiu-Vlad Ursache. All rights reserved.
//

#import "MainFeedViewController+CRConfigurationData.h"

@implementation MainFeedViewController (CRConfigurationData)

+ (NSString*)titleForTopic:(NSString*)topic {
    NSString* newTitle = @"";
    if ([topic caseInsensitiveCompare:@"HOME"]==NSOrderedSame) {
        newTitle = @"latest charlie rose shows";
    } else {
        newTitle = [NSString stringWithFormat:@"topic: %@",topic];
    }
    return [newTitle uppercaseString];
}

@end
