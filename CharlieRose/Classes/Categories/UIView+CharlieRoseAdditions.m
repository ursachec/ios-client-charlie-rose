//
//  UIView+CharlieRoseAdditions.m
//  CharlieRose
//
//  Created by Claudiu-Vlad Ursache on 28.11.12.
//  Copyright (c) 2012 Claudiu-Vlad Ursache. All rights reserved.
//

#import "UIView+CharlieRoseAdditions.h"
#import "CRErrorView.h"

@implementation UIView (CharlieRoseAdditions)

+ (UIView*)newLoadingViewWithSuperview:(UIView*)superview {

	UIView* loadingView = nil;
	CGRect loadingViewRect = CGRectMake(CGRectGetMinX(superview.frame), CGRectGetMinY(superview.frame), CGRectGetWidth(superview.bounds), CGRectGetHeight(superview.bounds));
	loadingView = [[UIView alloc] initWithFrame:loadingViewRect];
	loadingView.backgroundColor = [UIColor dimmedBlack];
	
	CGSize labelSize = CGSizeMake(250.0f, 20.0f);
	CGRect loadingViewLabelRect = CGRectMake((CGRectGetWidth(loadingView.bounds)-labelSize.width)/2, 230.0f, labelSize.width, labelSize.height);
	UILabel* loadingViewLabel = [[UILabel alloc] initWithFrame:loadingViewLabelRect];
	loadingViewLabel.backgroundColor = [UIColor dimmedBlack];
	loadingViewLabel.text = @"LOADING";
	loadingViewLabel.textColor = [UIColor redColor];
	loadingViewLabel.textAlignment = NSTextAlignmentCenter;
	loadingViewLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:12.0f];
	[loadingView addSubview:loadingViewLabel];
	
	return loadingView;
}

+ (CRErrorView*)newErrorViewWithSuperview:(UIView*)superview {
    
	CRErrorView* errorView = nil;
	CGRect loadingViewRect = CGRectMake(CGRectGetMinX(superview.frame), CGRectGetMinY(superview.frame), CGRectGetWidth(superview.bounds), CGRectGetHeight(superview.bounds));
	errorView = [[CRErrorView alloc] initWithFrame:loadingViewRect];
	errorView.backgroundColor = [UIColor dimmedBlack];
	
	CGSize labelSize = CGSizeMake(250.0f, 20.0f);
	CGRect errorViewLabelRect = CGRectMake((CGRectGetWidth(errorView.bounds)-labelSize.width)/2, 230.0f, labelSize.width, labelSize.height);
	UILabel* errorViewLabel = [[UILabel alloc] initWithFrame:errorViewLabelRect];
	errorViewLabel.backgroundColor = [UIColor dimmedBlack];
	errorViewLabel.text = @"ERROR";
	errorViewLabel.textColor = [UIColor redColor];
	errorViewLabel.textAlignment = NSTextAlignmentCenter;
	errorViewLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:12.0f];
	[errorView addSubview:errorViewLabel];
    
    errorView.errorTextLabel = errorViewLabel;
	
	return errorView;
}

@end
