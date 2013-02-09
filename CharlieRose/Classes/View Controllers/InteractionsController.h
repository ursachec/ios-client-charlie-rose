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


@class Show;

@interface InteractionsController : NSObject <IIViewDeckControllerDelegate>

+ (InteractionsController *)sharedInteractionsController;

- (id)initWithDeckViewController:(IIViewDeckController*)deckViewController;

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
