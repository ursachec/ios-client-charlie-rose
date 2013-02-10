//
//  InteractionsController.h
//  CharlieRose
//
//  Created by Claudiu-Vlad Ursache on 27.11.12.
//  Copyright (c) 2012 Claudiu-Vlad Ursache. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IIViewDeckController.h"

@class MenuViewController;
@class MainFeedViewController;
@class ShowDetailViewController;
@class IIViewDeckController;

@class SettingsViewController;
@class AboutViewController;
@class ContactViewController;

@class Show;

@interface InteractionsController : NSObject <IIViewDeckControllerDelegate>

@property (readonly, strong, nonatomic) IIViewDeckController* deckController;
@property (readonly, strong, nonatomic) SettingsViewController* settingsViewController;
@property (readonly, strong, nonatomic) AboutViewController* aboutViewController;
@property (readonly, strong, nonatomic) ContactViewController* contactViewController;

+ (InteractionsController *)sharedInteractionsController;

- (void)initializeAndSetupViewDeckController;

- (void)showMainFeedAnimated:(BOOL)animated;
- (void)showMenuAnimated:(BOOL)animated;
- (void)showDetailAnimated:(BOOL)animated;

- (void)showAboutAnimated:(BOOL)animated;
- (void)showContactAnimated:(BOOL)animated;
- (void)showSettingsAnimated:(BOOL)animated;
- (void)showMainFeedWithTopic:(NSString*)topic;
- (void)showDetailViewWithShowId:(NSString*)showId;

- (void)showDetailViewWithShow:(Show*)show;

@end
