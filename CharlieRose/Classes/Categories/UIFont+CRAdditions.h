//
//  UIFont+CRAdditions.h
//  CharlieRose
//
//  Created by Claudiu-Vlad Ursache on 27.11.12.
//  Copyright (c) 2012 Claudiu-Vlad Ursache. All rights reserved.
//

#import <UIKit/UIKit.h>

extern CGFloat const kShowCellTitleFontSize;
extern CGFloat const kShowCellDateFontSize;
extern CGFloat const kShowCellTopicsFontSize;

@interface UIFont (CRAdditions)

+ (UIFont*)applicationFontOfSize:(CGFloat)fontSize;
+ (UIFont*)boldApplicationFontOfSize:(CGFloat)fontSize;

+ (UIFont*)navigationTopicFont;
+ (UIFont*)menuCellLabelFont;
+ (UIFont*)showCellTitleFont;
+ (UIFont*)showCellDateFont;
+ (UIFont*)showCellTopicsFont;
+ (UIFont*)topicCellFont;
+ (UIFont*)loadingViewLabelFont;
+ (UIFont*)errorViewLabelFont;

#pragma mark - detail view controller
+ (UIFont*)detailHeadlineLabelFont;
+ (UIFont*)detailGuestsLabelFont;
+ (UIFont*)detailTopicsLabelFont;
+ (UIFont*)detailPublishingDataLabelFont;
+ (UIFont*)detailDescriptionTextViewFont;

#pragma mark - settings view controller
+ (UIFont*)explanatoryTextViewFont;
+ (UIFont*)toggleTrackingTitleLabelFont;

#pragma mark - contact view controller
+ (UIFont*)contactCharlieRoseIncTitleFont;
+ (UIFont*)contactCharlieRoseIncDetailFont;
+ (UIFont*)contactDeveloperTitleFont;
+ (UIFont*)contactDeveloperDetailFont;

@end
