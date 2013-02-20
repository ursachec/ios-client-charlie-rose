//
//  InteractionsController+Movement.h
//  CharlieRose
//
//  Created by Claudiu-Vlad Ursache on 10.02.13.
//  Copyright (c) 2013 Claudiu-Vlad Ursache. All rights reserved.
//

#import "InteractionsController.h"

@class CharlieRoseViewController;
@class Show;

@interface InteractionsController (Movement)

- (void)reactToTapOnContactViewControllerView;

- (void)showMainFeedInteractionForTapOnNavigationBar;

- (void)showMainFeedWithTopic:(NSString*)topic;
- (void)showDetailViewWithShow:(Show*)show;

- (void)showMainFeedAnimated:(BOOL)animated;
- (void)showMenuAnimated:(BOOL)animated;
- (void)showAboutAnimated:(BOOL)animated;
- (void)showSettingsAnimated:(BOOL)animated;
- (void)showContactAnimated:(BOOL)animated;
- (void)showPrivacyPolicyAnimated:(BOOL)animated;

- (void)showViewController:(CharlieRoseViewController*)controller inCenterViewAnimated:(BOOL)animated;
- (void)showViewController:(CharlieRoseViewController*)controller inCenterViewAnimated:(BOOL)animated showLoadingView:(BOOL)showLoadingView;
@end

