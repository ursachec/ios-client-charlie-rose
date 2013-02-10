//
//  MenuViewController+CRConfigurationData.h
//  CharlieRose
//
//  Created by Claudiu-Vlad Ursache on 10.02.13.
//  Copyright (c) 2013 Claudiu-Vlad Ursache. All rights reserved.
//

#import "MenuViewController.h"

@interface MenuViewController (CRConfigurationData)

- (NSArray*)appMenuItems;
- (NSArray*)appSections;
- (NSArray*)appTopics;
    
+ (BOOL)isTopicHomeTopic:(NSString*)topic;

@end
