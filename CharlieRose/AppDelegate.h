//
//  AppDelegate.h
//  CharlieRose
//
//  Created by Claudiu-Vlad Ursache on 25.11.12.
//  Copyright (c) 2012 Claudiu-Vlad Ursache. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CharlieRoseIncrementalStore.h"

@class MenuViewController;
@class MainFeedViewController;
@class ShowDetailViewController;
@class IIViewDeckController;
@class InteractionsController;
@class SettingsViewController;
@class AboutViewController;
@class ContactViewController;


@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@property (readonly, strong, nonatomic) IIViewDeckController* deckController;
@property (readonly, strong, nonatomic) MenuViewController* menuViewController;
@property (readonly, strong, nonatomic) MainFeedViewController* mainFeedViewController;
@property (readonly, strong, nonatomic) ShowDetailViewController* showDetailViewController;
@property (readonly, strong, nonatomic) SettingsViewController* settingsViewController;
@property (readonly, strong, nonatomic) AboutViewController* aboutViewController;
@property (readonly, strong, nonatomic) ContactViewController* contactViewController;

@property (readonly, strong, nonatomic) InteractionsController* interactionsController;


@property (strong, nonatomic) UINavigationController *navigationController;
- (void)saveContext;

@end
