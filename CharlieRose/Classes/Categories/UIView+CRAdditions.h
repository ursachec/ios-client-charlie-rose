//
//  UIView+CRAdditions.h
//  CharlieRose
//
//  Created by Claudiu-Vlad Ursache on 28.11.12.
//  Copyright (c) 2012 Claudiu-Vlad Ursache. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CRErrorView;

@interface UIView (CRAdditions)

+ (UIView*)newLoadingViewWithSuperview:(UIView*)superview;
+ (CRErrorView*)newErrorViewWithSuperview:(UIView*)superview;

@end
