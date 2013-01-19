//
//  CharlieRoseViewController.h
//  CharlieRose
//
//  Created by Claudiu-Vlad Ursache on 28.11.12.
//  Copyright (c) 2012 Claudiu-Vlad Ursache. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CharlieRoseViewController : UIViewController
@property(nonatomic, strong, readonly) UIView* superViewForLoadingView;
@property(nonatomic, strong, readonly) UIView* loadingView;
@property(nonatomic, assign, readonly) CGFloat loadingViewAnimationDuration;

- (void)showLoadingViewAnimated:(BOOL)animated;
- (void)hideLoadingViewAnimated:(BOOL)animated;

- (void)showLoadingViewAnimated:(BOOL)animated withCompletion:(void (^)(BOOL finished))completion;
- (void)hideLoadingViewAnimated:(BOOL)animated withCompletion:(void (^)(BOOL finished))completion;

@end
