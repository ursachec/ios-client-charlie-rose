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
#import "InteractionsController+Movement.h"

@interface InteractionsController ()

@property (readwrite, strong, nonatomic) IIViewDeckController* deckController;
@property (readwrite, strong, nonatomic) MenuViewController* menuViewController;
@property (readwrite, strong, nonatomic) MainFeedViewController* mainFeedViewController;
@property (readwrite, strong, nonatomic) ShowDetailViewController* showDetailViewController;
@property (readwrite, strong, nonatomic) SettingsViewController* settingsViewController;
@property (readwrite, strong, nonatomic) AboutViewController* aboutViewController;
@property (readwrite, strong, nonatomic) ContactViewController* contactViewController;

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


- (void)initializeAndSetupViewDeckController {
    self.mainFeedViewController = [[MainFeedViewController alloc] initWithNibName:nil bundle:nil];
	self.menuViewController = [[MenuViewController alloc] initWithNibName:nil bundle:nil];
	self.showDetailViewController = [[ShowDetailViewController alloc] initWithNibName:nil bundle:nil];
    
	IIViewDeckController* deckController =  [[IIViewDeckController alloc] initWithCenterViewController:self.mainFeedViewController
                                                                                    leftViewController:self.menuViewController
                                                                                   rightViewController:self.showDetailViewController];
    deckController.leftLedge = 120;
	deckController.rightLedge = 30;
	self.deckController = deckController;
    
    deckController.delegate = self;
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
#pragma mark - view deck controller delegate
- (BOOL)viewDeckControllerWillOpenRightView:(IIViewDeckController *)viewDeckController
                                   animated:(BOOL)animated {
	return YES;
}

- (BOOL)viewDeckControllerWillCloseLeftView:(IIViewDeckController*)viewDeckController
                                   animated:(BOOL)animated {
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

#pragma mark - lazy fetching view controllers

- (SettingsViewController*) settingsViewController {
	if (_settingsViewController==nil) {
		_settingsViewController = [[SettingsViewController alloc] initWithNibName:nil bundle:nil];
	}
	return _settingsViewController;
}

- (AboutViewController*) aboutViewController {
	if (_aboutViewController==nil) {
		_aboutViewController = [[AboutViewController alloc] initWithNibName:nil bundle:nil];
	}
	return _aboutViewController;
}

- (ContactViewController*) contactViewController {
	if (_contactViewController==nil) {
		_contactViewController = [[ContactViewController alloc] initWithNibName:nil bundle:nil];
	}
	return _contactViewController;
}

@end
