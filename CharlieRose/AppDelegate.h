//
//  AppDelegate.h
//  CharlieRose
//
//  Created by Claudiu-Vlad Ursache on 25.11.12.
//  Copyright (c) 2012 Claudiu-Vlad Ursache. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface AppDelegate : UIResponder <UIApplicationDelegate>
@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UINavigationController *navigationController;
@property (assign, nonatomic) BOOL hasImportedShowsForInitialImport;
@end
