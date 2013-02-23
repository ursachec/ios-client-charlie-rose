//
//  AppDelegate.h
//  CharlieRose
//
//  Created by Claudiu-Vlad Ursache on 25.11.12.
//  Copyright (c) 2012 Claudiu-Vlad Ursache. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CRNavigationController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>
@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) CRNavigationController *navigationController;
@property (assign, nonatomic) BOOL hasImportedShowsForInitialImport;
@end
