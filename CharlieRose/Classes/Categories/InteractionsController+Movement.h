//
//  InteractionsController+Movement.h
//  CharlieRose
//
//  Created by Claudiu-Vlad Ursache on 10.02.13.
//  Copyright (c) 2013 Claudiu-Vlad Ursache. All rights reserved.
//

#import "InteractionsController.h"

@class CharlieRoseViewController;

@interface InteractionsController (Movement)

- (void)showAboutAnimated:(BOOL)animated;
- (void)showViewController:(CharlieRoseViewController*)controller inCenterViewAnimated:(BOOL)animated;

@end
