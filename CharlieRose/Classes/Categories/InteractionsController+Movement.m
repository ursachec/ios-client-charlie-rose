//
//  InteractionsController+Movement.m
//  CharlieRose
//
//  Created by Claudiu-Vlad Ursache on 10.02.13.
//  Copyright (c) 2013 Claudiu-Vlad Ursache. All rights reserved.
//

#import "InteractionsController+Movement.h"
#import "AboutViewController.h"
#import "SettingsViewController.h"
#import "ContactViewController.h"
#import "CharlieRoseViewController.h"
#import "MainFeedViewController.h"
#import "ShowDetailViewController.h"
#import "PrivacyPolicyViewController.h"
#import <Mixpanel.h>
#import "Show.h"

@implementation InteractionsController (Movement)

#pragma mark - react to taps

- (void)reactToTapOnNonChangingViewController {
    IIViewDeckController* deckController = self.deckController;
    if (deckController.isSliding) {
        return;
    }
    
    deckController.isSliding = YES;
    if (deckController.leftControllerIsClosed && deckController.rightControllerIsClosed) {
        [deckController openLeftViewAnimated:YES
                                  completion:
         ^(IIViewDeckController *controller) {
                controller.isSliding = NO;
        }];
    } else {
        [deckController showCenterView:YES completion:^(IIViewDeckController *controller) {
            controller.isSliding = NO;
        }];
    }
}

- (void)reactToSwipeOnShowDetailViewController {
    [self reactToTapOnNonChangingViewController];
}
    
- (void)reactToTapOnShowDetailViewController {
    [self reactToTapOnNonChangingViewController];
}

- (void)reactToTapOnPrivacyPolicyViewController {
    [self reactToTapOnNonChangingViewController];
}

- (void)reactToTapOnSettingsViewController {
    [self reactToTapOnNonChangingViewController];
}

- (void)reactToTapOnAboutViewController {
    [self reactToTapOnNonChangingViewController];
}

- (void)reactToTapOnContactViewControllerView {
    [self reactToTapOnNonChangingViewController];
}

#pragma mark - other interactions

- (void)showMainFeedInteractionForTapOnNavigationBar {    
    IIViewDeckController* deck = self.deckController;
    if (deck.leftControllerIsClosed && deck.rightControllerIsClosed) {
        [deck openLeftView];
    } else {
        [deck showCenterView]; 
    }
    [self trackMovementWithMethod:@"showMainFeedInteractionForTapOnNavigationBar"];
}

- (void)trackMovementWithMethod:(NSString*)method {
    NSString* trackingName = [NSString stringWithFormat:@"[movement] %@",method];
    [[Mixpanel sharedInstance] track:trackingName];
}

- (void)showDetailViewWithShow:(Show*)show {
	[self.deckController toggleRightView];
	[self.showDetailViewController presentWithShow:show];
    NSString* trackingName = [NSString stringWithFormat:@"[movement] showDetailViewWithShow:%@",show.showID];
    [self trackMovementWithMethod:trackingName];
}

- (void)showMenuAnimated:(BOOL)animated {
	[self.deckController toggleLeftView];
    [self trackMovementWithMethod:@"showMenuAnimated"];
}

- (void)showAboutAnimated:(BOOL)animated {
	AboutViewController* aboutViewController = self.aboutViewController;
	[self showViewController:aboutViewController inCenterViewAnimated:animated];
    [self trackMovementWithMethod:@"showAboutAnimated"];
}

- (void)showContactAnimated:(BOOL)animated {
	ContactViewController* contactViewController = self.contactViewController;
	[self showViewController:contactViewController inCenterViewAnimated:animated];
    [self trackMovementWithMethod:@"showContactAnimated"];
}

- (void)showSettingsAnimated:(BOOL)animated {
	SettingsViewController* settingsViewController = self.settingsViewController;
	[self showViewController:settingsViewController inCenterViewAnimated:animated];
    [self trackMovementWithMethod:@"showSettingsAnimated"];
}

- (void)showPrivacyPolicyAnimated:(BOOL)animated {
	PrivacyPolicyViewController* privacyPolicyViewController = self.privacyPolicyViewController;
	[self showViewController:privacyPolicyViewController inCenterViewAnimated:animated];
    [self trackMovementWithMethod:@"showPrivacyPolicyAnimated"];
}

- (void)showMainFeedWithTopic:(NSString*)topic {
    [self showMainFeedWithTopic:topic animated:YES];
}

- (void)showMainFeedWithTopic:(NSString*)topic animated:(BOOL)animated {
    [self showViewController:self.mainFeedViewController inCenterViewAnimated:animated];
	[self.deckController showCenterView];
	[self.mainFeedViewController showTopic:topic];
}

- (void)showMainFeedAnimated:(BOOL)animated {
	[self showViewController:self.mainFeedViewController inCenterViewAnimated:animated];
	[self.deckController showCenterView];
	[self.mainFeedViewController showTopicHome];
}

- (void)showViewController:(CharlieRoseViewController*)controller inCenterViewAnimated:(BOOL)animated showLoadingView:(BOOL)showLoadingView {
    CharlieRoseViewController* currentCenterController = (CharlieRoseViewController*)[self.deckController centerController];
	BOOL shouldChangeCenterViewController = (currentCenterController!=controller);
	if (shouldChangeCenterViewController) {
        self.deckController.centerController = controller;
        if (showLoadingView) {
            [currentCenterController showLoadingViewAnimated:animated completion:^(BOOL finished) {
                if (finished) {
                    [controller hideLoadingOrErrorViewAnimated:animated];
                    [currentCenterController hideLoadingOrErrorViewAnimated:animated];
                }
            }];
        }
	}
	[self.deckController showCenterView];
}

- (void)showViewController:(CharlieRoseViewController*)controller inCenterViewAnimated:(BOOL)animated {
	[self showViewController:controller inCenterViewAnimated:animated showLoadingView:NO];
}

@end
