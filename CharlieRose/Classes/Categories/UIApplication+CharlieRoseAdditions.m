//
//  UIApplication+CharlieRoseAdditions.m
//  CharlieRose
//
//  Created by Claudiu-Vlad Ursache on 27.11.12.
//  Copyright (c) 2012 Claudiu-Vlad Ursache. All rights reserved.
//

#import "UIApplication+CharlieRoseAdditions.h"

@implementation UIApplication (CharlieRoseAdditions)
+ (AppDelegate*)sharedAppDelegate {
	return (AppDelegate*)[[UIApplication sharedApplication] delegate];
}
+ (InteractionsController*)sharedInteractionsController {
	return ((AppDelegate*)[[UIApplication sharedApplication] delegate]).interactionsController;
}
@end
