//
//  AppDelegate.m
//  CharlieRose
//
//  Created by Claudiu-Vlad Ursache on 25.11.12.
//  Copyright (c) 2012 Claudiu-Vlad Ursache. All rights reserved.
//

#import "AppDelegate.h"
#import "AFNetworkActivityIndicatorManager.h"
#import "InteractionsController.h"
#import "CRDBHandler.h"
#import "UIColor+CRAdditions.h"
#import "UIFont+CRAdditions.h"
#import "NSUserDefaults+CRAdditions.h"
#import "Mixpanel.h"
#import "SecretDefines.h"
#import "CRNavigationController.h"

static NSString* kMixpanelToken = MIXPANEL_TOKEN;

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application
didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
	self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
	
	[self setupApperanceProxyCustomizations];
    
    [AFNetworkActivityIndicatorManager.sharedManager setEnabled:YES];

    InteractionsController *interactionsCtl = InteractionsController.sharedInteractionsController;
    [interactionsCtl initializeAndSetupViewDeckController];
    [self setupNavigationControllerWithInteractionsController:interactionsCtl];
    
    self.window.rootViewController = self.navigationController;
    
    if (NO == NSUserDefaults.hasSetTrackingDenied) {
        [Mixpanel sharedInstanceWithToken:kMixpanelToken];
        [Mixpanel.sharedInstance track:@"Launched Application"];
    }
    
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)setupNavigationControllerWithInteractionsController:(InteractionsController*)controller {
    CRNavigationController *navigationController = [[CRNavigationController alloc] initWithNavigationBarClass:[UINavigationBar class] toolbarClass:[UIToolbar class]];
    navigationController.navigationBarHidden = YES;
    NSArray *viewControllers = @[controller.deckController];
    navigationController.viewControllers = viewControllers;
    self.navigationController = navigationController;
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
    [CRDBHandler.sharedDBHandler saveContext];
}



#pragma mark - appearance proxy

-(void)setupApperanceProxyCustomizations {
    [[UINavigationBar appearance] setBarStyle:UIBarStyleBlackTranslucent];
    [[UIBarButtonItem appearance] setTintColor:[UIColor dimmedBlack]];
    
    [[UISwitch appearance] setOnTintColor:[UIColor redColor]];
    [[UISwitch appearance] setTintColor:[UIColor dimmedBlack]];
    [[UISwitch appearance] setThumbTintColor:[UIColor whiteColor]];
    [[UINavigationBar appearance] setTintColor:[UIColor dimmedBlack]];
    
    NSMutableDictionary* attributes = @{}.mutableCopy;
    attributes[UITextAttributeTextColor] = [UIColor whiteColor];
    [[UIBarButtonItem appearance] setTitleTextAttributes:attributes
                                                forState:UIControlStateNormal];
}

@end
