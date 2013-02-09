//
//  AppDelegate.m
//  CharlieRose
//
//  Created by Claudiu-Vlad Ursache on 25.11.12.
//  Copyright (c) 2012 Claudiu-Vlad Ursache. All rights reserved.
//

#import "AppDelegate.h"

#import "AFNetworkActivityIndicatorManager.h"

#import "IIViewDeckController.h"
#import "MenuViewController.h"
#import "MainFeedViewController.h"
#import "ShowDetailViewController.h"

#import "SettingsViewController.h"
#import "AboutViewController.h"
#import "ContactViewController.h"

#import "InteractionsController.h"

@interface AppDelegate()
@property (readwrite, strong, nonatomic) IIViewDeckController* deckController;
@property (readwrite, strong, nonatomic) MenuViewController* menuViewController;
@property (readwrite, strong, nonatomic) MainFeedViewController* mainFeedViewController;
@property (readwrite, strong, nonatomic) ShowDetailViewController* showDetailViewController;

@property (readwrite, strong, nonatomic) SettingsViewController* settingsViewController;
@property (readwrite, strong, nonatomic) AboutViewController* aboutViewController;
@property (readwrite, strong, nonatomic) ContactViewController* contactViewController;

@property (readwrite, strong, nonatomic) InteractionsController* interactionsController;

@end

@implementation AppDelegate

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (BOOL)application:(UIApplication *)application
didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    NSURLCache *URLCache = [[NSURLCache alloc] initWithMemoryCapacity:8 * 1024 * 1024 diskCapacity:20 * 1024 * 1024 diskPath:nil];
    [NSURLCache setSharedURLCache:URLCache];

    
	self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
	
	[self setupApperanceProxyCustomizations];
    
    [[AFNetworkActivityIndicatorManager sharedManager] setEnabled:YES];
    
    self.mainFeedViewController = [[MainFeedViewController alloc] initWithNibName:nil bundle:nil];

	self.menuViewController = [[MenuViewController alloc] initWithNibName:nil bundle:nil];
	self.showDetailViewController = [[ShowDetailViewController alloc] initWithNibName:nil bundle:nil];
	IIViewDeckController* deckController =  [[IIViewDeckController alloc] initWithCenterViewController:self.mainFeedViewController
                                                                                    leftViewController:self.menuViewController
                                                                                   rightViewController:self.showDetailViewController];
    deckController.leftLedge = 120;
	deckController.rightLedge = 30;
	self.deckController = deckController;
	
    
	
	self.interactionsController = [[InteractionsController alloc] initWithDeckViewController:self.deckController];
    
    self.window.rootViewController = deckController;
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
	// Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
	// Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
	// Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
	// If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
	// Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
	// Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
	// Saves changes in the application's managed object context before the application terminates.
	[self saveContext];
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



#pragma mark - Core Data

- (void)saveContext {
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

- (NSManagedObjectContext *)managedObjectContext {
    if (_managedObjectContext) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator) {
        _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
        [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    
    return _managedObjectContext;
}

- (NSManagedObjectModel *)managedObjectModel {
    if (_managedObjectModel) {
        return _managedObjectModel;
    }
    
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"CharlieRose" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    if (_persistentStoreCoordinator) {
        return _persistentStoreCoordinator;
    }
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    
    AFIncrementalStore *incrementalStore = (AFIncrementalStore *)[_persistentStoreCoordinator addPersistentStoreWithType:[CharlieRoseIncrementalStore type] configuration:nil URL:nil options:nil error:nil];
    
    NSURL *applicationDocumentsDirectory = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
    NSURL *storeURL = [applicationDocumentsDirectory URLByAppendingPathComponent:@"CharlieRose.sqlite"];
    
    NSDictionary *options = @{
        NSInferMappingModelAutomaticallyOption : @(YES),
        NSMigratePersistentStoresAutomaticallyOption: @(YES)
    };
    
    NSError *error = nil;
    if (![incrementalStore.backingPersistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:options error:&error]) {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}

#pragma mark - appearance proxy

-(void)setupApperanceProxyCustomizations {
    [[UINavigationBar appearance] setBarStyle:UIBarStyleBlackTranslucent];
    [[UIBarButtonItem appearance] setTintColor:[UIColor dimmedBlack]];
}


@end
