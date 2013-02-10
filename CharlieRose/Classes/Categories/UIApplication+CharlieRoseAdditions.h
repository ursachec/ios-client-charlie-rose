//
//  UIApplication+CharlieRoseAdditions.h
//  CharlieRose
//
//  Created by Claudiu-Vlad Ursache on 27.11.12.
//  Copyright (c) 2012 Claudiu-Vlad Ursache. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "InteractionsController.h"

@interface UIApplication (CharlieRoseAdditions)
+ (AppDelegate*)sharedAppDelegate;
+ (InteractionsController*)sharedInteractionsController;
- (BOOL)hasImportedShowsForInitialImport;
@end
