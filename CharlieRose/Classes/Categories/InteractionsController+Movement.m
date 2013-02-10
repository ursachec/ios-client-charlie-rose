//
//  InteractionsController+Movement.m
//  CharlieRose
//
//  Created by Claudiu-Vlad Ursache on 10.02.13.
//  Copyright (c) 2013 Claudiu-Vlad Ursache. All rights reserved.
//

#import "InteractionsController+Movement.h"
#import "AboutViewController.h"
#import "CharlieRoseViewController.h"

@implementation InteractionsController (Movement)

- (void)showAboutAnimated:(BOOL)animated {
	AboutViewController* aboutViewController = self.aboutViewController;
	[self showViewController:aboutViewController inCenterViewAnimated:YES];
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
