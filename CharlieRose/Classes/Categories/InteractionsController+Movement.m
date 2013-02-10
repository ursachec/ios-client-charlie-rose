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

#import "Show.h"

@implementation InteractionsController (Movement)

- (void)showMainFeedWithTopic:(NSString*)topic {
	[self showViewController:self.mainFeedViewController inCenterViewAnimated:YES];
	[self.deckController showCenterView];
	[self.mainFeedViewController showTopic:topic];
}

- (void)showDetailViewWithShow:(Show*)show {
	[self.deckController toggleRightView];
	[self.showDetailViewController presentWithShow:show];}

- (void)showDetailViewWithShowId:(NSString*)showId {
	[self.deckController toggleRightView];
	[self.showDetailViewController showWithShowId:showId];
}

- (void)showMenuAnimated:(BOOL)animated {
	[self.deckController toggleLeftView];
}

- (void)showAboutAnimated:(BOOL)animated {
	AboutViewController* aboutViewController = self.aboutViewController;
	[self showViewController:aboutViewController inCenterViewAnimated:YES];
}

- (void)showContactAnimated:(BOOL)animated {
	ContactViewController* contactViewController = self.contactViewController;
	[self showViewController:contactViewController inCenterViewAnimated:YES];
}

- (void)showSettingsAnimated:(BOOL)animated {
	SettingsViewController* settingsViewController = self.settingsViewController;
	[self showViewController:settingsViewController inCenterViewAnimated:YES];
}

- (void)showMainFeedAnimated:(BOOL)animated {
	[self showViewController:self.mainFeedViewController inCenterViewAnimated:YES];
	[self.deckController showCenterView];
	[self.mainFeedViewController showTopic:@"home"];
}



- (void)showDetailAnimated:(BOOL)animated {
	[self.deckController toggleRightView];
	
	[self.showDetailViewController showLoadingViewAnimated:YES];
	
	int64_t delayInSeconds = 1.0;
	dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
	dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
		[self.showDetailViewController hideLoadingViewAnimated:YES];
	});
	
}

- (void)showViewController:(CharlieRoseViewController*)controller inCenterViewAnimated:(BOOL)animated {
	CharlieRoseViewController* currentCenterController = (CharlieRoseViewController*)[self.deckController centerController];
	BOOL shouldChangeCenterViewController = (currentCenterController!=controller);
	if (shouldChangeCenterViewController) {
		[currentCenterController showLoadingViewAnimated:YES withCompletion:^(BOOL finished) {
			if (finished) {
				self.deckController.centerController = controller;
				[controller hideLoadingViewAnimated:YES];
				[currentCenterController hideLoadingViewAnimated:NO];
			}
		}];
	}
	[self.deckController showCenterView];
}

@end
