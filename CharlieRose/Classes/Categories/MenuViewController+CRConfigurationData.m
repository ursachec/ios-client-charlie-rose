//
//  MenuViewController+CRConfigurationData.m
//  CharlieRose
//
//  Created by Claudiu-Vlad Ursache on 10.02.13.
//  Copyright (c) 2013 Claudiu-Vlad Ursache. All rights reserved.
//

#import "MenuViewController+CRConfigurationData.h"
#import "NSArray+CRAdditions.h"

@implementation MenuViewController (CRConfigurationData)

- (NSArray*)appMenuItems {
    NSArray* items = @[@"SETTINGS", @"ABOUT", @"CONTACT"];
    return [NSArray arrayWithUppercaseStrings:items];
}

- (NSArray*)appSections {
    NSArray* sections = @[@"Topics",@"MenuItems"];
    return [NSArray arrayWithUppercaseStrings:sections];
}

- (NSArray*)appTopics {
    NSArray* items = @[@"Home", @"Art & Design", @"Books", @"Business", @"Current Affairs", @"History", @"In Memoriam", @"Lifestyle", @"Movies, TV & Theater", @"Music", @"Science & Health", @"Sports", @"Technology" ];
    return [NSArray arrayWithUppercaseStrings:items];
}

+ (BOOL)isTopicHomeTopic:(NSString*)topic {
    if (topic &&
        ([topic caseInsensitiveCompare:@"Home"] == NSOrderedSame ||
         [topic caseInsensitiveCompare:@"all"] == NSOrderedSame)) {
            return YES;
        }
    return NO;
}


@end
