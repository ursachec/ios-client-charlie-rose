//
//  CharlieRoseViewController.m
//  CharlieRose
//
//  Created by Claudiu-Vlad Ursache on 28.11.12.
//  Copyright (c) 2012 Claudiu-Vlad Ursache. All rights reserved.
//

#import "CharlieRoseViewController.h"

#import "UIView+CharlieRoseAdditions.h"
#import "CRErrorView.h"

@interface CharlieRoseViewController ()
@property(nonatomic, strong, readwrite) UIView* superViewForLoadingView;
@property(nonatomic, strong, readwrite) UIView* loadingView;
@property(nonatomic, strong, readwrite) CRErrorView* errorView;
@property(nonatomic, assign, readwrite) CGFloat loadingViewAnimationDuration;

@end

@implementation CharlieRoseViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - error view

- (void)showErrorViewWithMessage:(NSString*)message {
    
}

#pragma mark - loading view

- (void)showLoadingViewAnimated:(BOOL)animated {
	[self showLoadingViewAnimated:animated withCompletion:NULL];
}

- (void)showLoadingViewAnimated:(BOOL)animated withCompletion:(void (^)(BOOL finished))completion {
	UIView* loadingView = self.loadingView;
	if (animated==NO) {
		loadingView.alpha = 1.0f;
		[self.view addSubview:loadingView];
	} else {
		loadingView.alpha = 0.0f;
		loadingView.userInteractionEnabled = YES;
		[self.view addSubview:loadingView];
		[UIView animateWithDuration:self.loadingViewAnimationDuration
						 animations:^{
							 loadingView.alpha = 1.0f;
						 } completion:completion];
	}
	return;
}

- (void)hideLoadingViewAnimated:(BOOL)animated {
	[self hideLoadingViewAnimated:animated withCompletion:NULL];
}

- (void)hideLoadingViewAnimated:(BOOL)animated withCompletion:(void (^)(BOOL finished))completion {
	UIView* loadingView = self.loadingView;
	if (animated==NO) {
		[loadingView removeFromSuperview];
	} else {
		loadingView.alpha = 1.0f;
		loadingView.userInteractionEnabled = YES;
		[self.view addSubview:loadingView];
		[UIView animateWithDuration:self.loadingViewAnimationDuration
						 animations:^{
							 loadingView.alpha = 0.0f;
						 } completion:completion];
	}
	return;
}

- (CRErrorView*)errorView {
	if (_errorView==nil) {
		_errorView = [UIView newErrorViewWithSuperview:self.superViewForLoadingView];
	}
	return _errorView;
}

- (UIView*)loadingView {
	if (_loadingView==nil) {
		_loadingView = [UIView newLoadingViewWithSuperview:self.superViewForLoadingView];
	}
	return _loadingView;
}

- (UIView*)superViewForLoadingView {
	return self.view;
}

- (CGFloat)loadingViewAnimationDuration {
	return .3f;
}

@end
