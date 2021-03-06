//
//  InteractionsController.h
//  CharlieRose
//
//  Created by Claudiu-Vlad Ursache on 27.11.12.
//  Copyright (c) 2012 Claudiu-Vlad Ursache. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MediaPlayer/MediaPlayer.h>
#import "IIViewDeckController.h"

@class MenuViewController;
@class MainFeedViewController;
@class ShowDetailViewController;
@class IIViewDeckController;
@class SettingsViewController;
@class AboutViewController;
@class ContactViewController;
@class PrivacyPolicyViewController;

@protocol IIViewDeckControllerDelegate;

@interface InteractionsController : NSObject <IIViewDeckControllerDelegate>

@property (readonly, strong, nonatomic) IIViewDeckController* deckController;
@property (readonly, strong, nonatomic) PrivacyPolicyViewController* privacyPolicyViewController;
@property (readonly, strong, nonatomic) SettingsViewController* settingsViewController;
@property (readonly, strong, nonatomic) AboutViewController* aboutViewController;
@property (readonly, strong, nonatomic) ContactViewController* contactViewController;
@property (readonly, strong, nonatomic) MainFeedViewController* mainFeedViewController;
@property (readonly, strong, nonatomic) ShowDetailViewController* showDetailViewController;

+ (InteractionsController *)sharedInteractionsController;

- (void)initializeAndSetupViewDeckController;
- (void)showVideoPlayerForURL:(NSURL*)videoURL;

-(void)registerForNotificationsFromMoviePlayer:(MPMoviePlayerController*)moviePlayer;
-(void)deregisterForNotificationsFromMoviePlayer:(MPMoviePlayerController*)moviePlayer;

@end

@protocol InteractionsControllerFullViewTapDelegate <NSObject>
@optional
- (IBAction)didTapOnView:(id)sender;
@end
