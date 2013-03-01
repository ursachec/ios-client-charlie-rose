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
#import "PrivacyPolicyViewController.h"

#import "UIApplication+CRAdditions.h"
#import "InteractionsController+Movement.h"

@interface InteractionsController ()
@property (readwrite, strong, nonatomic) IIViewDeckController* deckController;
@property (readwrite, strong, nonatomic) MenuViewController* menuViewController;
@property (readwrite, strong, nonatomic) SettingsViewController* settingsViewController;
@property (readwrite, strong, nonatomic) PrivacyPolicyViewController* privacyPolicyViewController;
@property (readwrite, strong, nonatomic) AboutViewController* aboutViewController;
@property (readwrite, strong, nonatomic) ContactViewController* contactViewController;
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

- (void)initializeAndSetupViewDeckController {
    self.mainFeedViewController = [[MainFeedViewController alloc] initWithNibName:nil bundle:nil];
	self.menuViewController = [[MenuViewController alloc] initWithNibName:nil bundle:nil];
	self.showDetailViewController = [[ShowDetailViewController alloc] init];
    
	IIViewDeckController* deckController =  [[IIViewDeckController alloc] initWithCenterViewController:self.mainFeedViewController
                                                                                    leftViewController:self.menuViewController
                                                                                   rightViewController:self.showDetailViewController];
    deckController.leftLedge = 120;
	deckController.rightLedge = 30;
	self.deckController = deckController;
    
    deckController.delegate = self;
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

#pragma mark - lazy fetching view controllers

- (PrivacyPolicyViewController*) privacyPolicyViewController {
	if (_privacyPolicyViewController==nil) {
		_privacyPolicyViewController = [[PrivacyPolicyViewController alloc] initWithNibName:nil bundle:nil];
	}
	return _privacyPolicyViewController;
}

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

#pragma mark - present video player
- (void)showVideoPlayerForURL:(NSURL*)videoURL {
    NSLog(@"showVideoPlayerForURL: %@", videoURL);
}

#pragma mark - autorotation

-(void)registerForNotificationsFromMoviePlayer:(MPMoviePlayerController*)moviePlayer {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(notification_didEnterFullscreen:)
                                                 name:MPMoviePlayerDidEnterFullscreenNotification object:moviePlayer];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(notification_willExitFullscreen:)
                                                 name:MPMoviePlayerWillExitFullscreenNotification object:moviePlayer];    
}

-(void)deregisterForNotificationsFromMoviePlayer:(MPMoviePlayerController*)moviePlayer {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:MPMoviePlayerDidEnterFullscreenNotification object:moviePlayer];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:MPMoviePlayerWillExitFullscreenNotification object:moviePlayer];
}

- (void)notification_didEnterFullscreen:(NSNotification*)notification {
    [self.deckController.viewDeckController setAllowRotation:YES];
}

- (void)notification_willExitFullscreen:(NSNotification*)notification {
    [self.deckController.viewDeckController setAllowRotation:NO];
    if ([notification.object isKindOfClass:MPMoviePlayerController.class] ) {
        [self deregisterForNotificationsFromMoviePlayer:notification.object];
    }
}

@end
