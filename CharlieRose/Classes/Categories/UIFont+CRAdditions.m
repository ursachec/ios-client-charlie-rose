//
//  UIFont+CRAdditions.m
//  CharlieRose
//
//  Created by Claudiu-Vlad Ursache on 27.11.12.
//  Copyright (c) 2012 Claudiu-Vlad Ursache. All rights reserved.
//

#import "UIFont+CRAdditions.h"

const CGFloat kShowCellTitleFontSize = 12.0f;
const CGFloat kShowCellDateFontSize = 10.0f;
const CGFloat kShowCellTopicsFontSize = 10.0f;

static NSString * kFontNameRegular = @"Merriweather";
static NSString * kFontNameBold = @"Merriweather-Bold";

@implementation UIFont (CRAdditions)

+ (UIFont*)applicationFontOfSize:(CGFloat)fontSize {
    return [UIFont fontWithName:kFontNameRegular size:fontSize];
}

+ (UIFont*)boldApplicationFontOfSize:(CGFloat)fontSize {
    return [UIFont fontWithName:kFontNameBold size:fontSize];
}

+ (UIFont*)navigationTopicFont {
    return [UIFont applicationFontOfSize:12.0f];
}

+ (UIFont*)showCellTitleFont {
    return [UIFont applicationFontOfSize:kShowCellTitleFontSize];
}

+ (UIFont*)showCellDateFont {
    return [UIFont applicationFontOfSize:kShowCellDateFontSize];
}

+ (UIFont*)showCellTopicsFont {
    return [UIFont applicationFontOfSize:kShowCellTopicsFontSize];
}

+ (UIFont*)menuCellLabelFont {
    return [UIFont boldApplicationFontOfSize:14.0f];
}

+ (UIFont*)topicCellFont {
    return [UIFont applicationFontOfSize:12.0f];
}

+ (UIFont*)loadingViewLabelFont {
    return [UIFont boldApplicationFontOfSize:12.0f];
}

+ (UIFont*)errorViewLabelFont {
    return [UIFont boldApplicationFontOfSize:12.0f];
}

#pragma mark - detail view controller
+ (UIFont*)detailHeadlineLabelFont {
	return [UIFont applicationFontOfSize:16.0f];
}
+ (UIFont*)detailGuestsLabelFont {
	return [UIFont applicationFontOfSize:12.0f];
}
+ (UIFont*)detailTopicsLabelFont {
	return [UIFont applicationFontOfSize:12.0f];
}
+ (UIFont*)detailPublishingDataLabelFont {
	return [UIFont applicationFontOfSize:12.0f];
}
+ (UIFont*)detailDescriptionTextViewFont {
	return [UIFont applicationFontOfSize:12.0f];
}

#pragma mark - settings view controller
+ (UIFont*)explanatoryTextViewFont {
	return [UIFont applicationFontOfSize:12.0f];
}

+ (UIFont*)toggleTrackingTitleLabelFont {
	return [UIFont applicationFontOfSize:12.0f];
}

@end
