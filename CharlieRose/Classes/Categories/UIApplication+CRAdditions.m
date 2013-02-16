//
//  UIApplication+CRAdditions.m
//  CharlieRose
//
//  Created by Claudiu-Vlad Ursache on 27.11.12.
//  Copyright (c) 2012 Claudiu-Vlad Ursache. All rights reserved.
//

#import "UIApplication+CRAdditions.h"
#import "InteractionsController.h"

@implementation UIApplication (CRAdditions)
+ (AppDelegate*)sharedAppDelegate {
	return (AppDelegate*)[[UIApplication sharedApplication] delegate];
}
+ (InteractionsController*)sharedInteractionsController {
	return [InteractionsController sharedInteractionsController];
}



@end