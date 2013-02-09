//
//  InteractionsController.m
//  CharlieRose
//
//  Created by Claudiu-Vlad Ursache on 27.11.12.
//  Copyright (c) 2012 Claudiu-Vlad Ursache. All rights reserved.
//

#import "InteractionsController.h"
#import "MenuViewController.h"
#import "MainFeedViewController.h"
#import "ShowDetailViewController.h"


#import "AboutViewController.h"
#import "SettingsViewController.h"
#import "ContactViewController.h"

#import "Show.h"

#import "UIApplication+CharlieRoseAdditions.h"


@interface InteractionsController ()
@property (readwrite, strong, nonatomic) IIViewDeckController* deckController;
@property (readwrite, strong, nonatomic) MenuViewController* menuViewController;
@property (readwrite, strong, nonatomic) MainFeedViewController* mainFeedViewController;
@property (readwrite, strong, nonatomic) ShowDetailViewController* showDetailViewController;
@end

@implementation InteractionsController

+ (InteractionsController *)sharedInteractionsController {
    static InteractionsController *_sharedInteractionsController = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInteractionsController = [[InteractionsController alloc] init];
    });
    
    return _sharedInteractionsController;
}
- (id)initWithDeckViewController:(IIViewDeckController*)deckViewController {
	self = [super init];
	if (self) {
		_deckController = deckViewController;
		_menuViewController = (MenuViewController*)deckViewController.leftController;
		_mainFeedViewController = (MainFeedViewController*)deckViewController.centerController;
		_showDetailViewController = (ShowDetailViewController*)deckViewController.rightController;
	}
	return self;
}

- (void)showAboutAnimated:(BOOL)animated {
	AboutViewController* aboutViewController = [UIApplication sharedAppDelegate].aboutViewController;
	[self showViewController:aboutViewController inCenterViewAnimated:YES];
}

- (void)showContactAnimated:(BOOL)animated {
	ContactViewController* contactViewController = [UIApplication sharedAppDelegate].contactViewController;
	[self showViewController:contactViewController inCenterViewAnimated:YES];
}

- (void)showSettingsAnimated:(BOOL)animated {
	SettingsViewController* settingsViewController = [UIApplication sharedAppDelegate].settingsViewController;
	[self showViewController:settingsViewController inCenterViewAnimated:YES];
}

- (void)showMainFeedAnimated:(BOOL)animated {
	[self showViewController:self.mainFeedViewController inCenterViewAnimated:YES];
	[self.deckController showCenterView];	
	[self.mainFeedViewController showTopic:@"home"];
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

- (void)showDetailAnimated:(BOOL)animated {
	[self.deckController toggleRightView];
	
	[self.showDetailViewController showLoadingViewAnimated:YES];
	
	int64_t delayInSeconds = 1.0;
	dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
	dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
		[self.showDetailViewController hideLoadingViewAnimated:YES];
	});
	
}
#pragma mark - view deck controller delegate
- (BOOL)viewDeckControllerWillOpenRightView:(IIViewDeckController *)viewDeckController animated:(BOOL)animated {
	
	return YES;
}

- (BOOL)viewDeckControllerWillCloseLeftView:(IIViewDeckController*)viewDeckController animated:(BOOL)animated {
	
	return YES;
}

#pragma mark - high level show methods

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

@end
