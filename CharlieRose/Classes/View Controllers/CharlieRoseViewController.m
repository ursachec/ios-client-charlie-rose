//
//  CharlieRoseViewController.m
//  CharlieRose
//
//  Created by Claudiu-Vlad Ursache on 28.11.12.
//  Copyright (c) 2012 Claudiu-Vlad Ursache. All rights reserved.
//

#import "CharlieRoseViewController.h"

#import "UIView+CRAdditions.h"
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

- (void)showErrorViewAnimated:(BOOL)animated
                      message:(NSString*)message {
    self.errorView.errorTextLabel.text = message;
    [self showErrorViewAnimated:animated message:message completion:NULL];
}

- (void)showErrorViewAnimated:(BOOL)animated
                      message:(NSString*)message
                   completion:(void (^)(BOOL finished))completion {
    CRErrorView* errorView = self.errorView;
    if (errorView.superview) {
        return;
    }
    
	if (NO == animated) {
		errorView.alpha = 1.0f;
		[self.view addSubview:errorView];
	} else {
		errorView.alpha = 0.0f;
		errorView.userInteractionEnabled = YES;
		[self.view addSubview:errorView];
		[UIView animateWithDuration:self.errorViewAnimationDuration
						 animations:^{
							 errorView.alpha = 1.0f;
						 } completion:completion];
	}
}

- (void)hideErrorViewAnimated:(BOOL)animated {
	[self hideErrorViewAnimated:animated completion:NULL];
}

- (void)hideErrorViewAnimated:(BOOL)animated completion:(void (^)(BOOL finished))completion {
	CRErrorView* errorView = self.errorView;
    
	if (NO == animated) {
		[errorView removeFromSuperview];
	} else {
		errorView.alpha = 1.0f;
		errorView.userInteractionEnabled = YES;
		[self.view addSubview:errorView];
		[UIView animateWithDuration:self.errorViewAnimationDuration
						 animations:^{
							 errorView.alpha = 0.0f;
						 } completion:completion];
	}
}

- (CRErrorView*)errorView {
	if (_errorView == nil) {
		_errorView = [UIView newErrorViewWithSuperview:self.superViewForLoadingView];
	}
	return _errorView;
}

#pragma mark - loading view

- (void)showLoadingViewAnimated:(BOOL)animated {
	[self showLoadingViewAnimated:animated completion:NULL];
}

- (void)showLoadingViewAnimated:(BOOL)animated completion:(void (^)(BOOL finished))completion {
	UIView* loadingView = self.loadingView;
    if (loadingView.superview) {
        return;
    }
    
	if (NO == animated) {
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
}

- (void)hideLoadingViewAnimated:(BOOL)animated {
	[self hideLoadingViewAnimated:animated withCompletion:NULL];
}

- (void)hideLoadingViewAnimated:(BOOL)animated withCompletion:(void (^)(BOOL finished))completion {
	UIView* loadingView = self.loadingView;
	if (NO == animated) {
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
	return 1.2f;
}

- (CGFloat)errorViewAnimationDuration {
	return self.loadingViewAnimationDuration;
}


- (void)hideLoadingOrErrorViewAnimated:(BOOL)animated {
    if (self.loadingView.superview) {
        [self hideLoadingViewAnimated:YES];
    }else if (self.errorView.superview) {
        [self hideErrorViewAnimated:YES];
    }
}

@end
