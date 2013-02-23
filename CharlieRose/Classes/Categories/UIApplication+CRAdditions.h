//
//  UIApplication+CRAdditions.h
//  CharlieRose
//
//  Created by Claudiu-Vlad Ursache on 27.11.12.
//  Copyright (c) 2012 Claudiu-Vlad Ursache. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "InteractionsController+Movement.h"
#import "CRNavigationController.h"

@interface UIApplication (CRAdditions)
+ (AppDelegate*)sharedAppDelegate;
+ (InteractionsController*)sharedInteractionsController;
+ (CRNavigationController*)sharedNavigationController;
@end
