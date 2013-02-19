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

+ (UIFont*)headline1Font {
    return [UIFont applicationFontOfSize:16.0f];
}

+ (UIFont*)headline3Font {
    return [UIFont applicationFontOfSize:13.0f];
}

+ (UIFont*)paragraphFont {
    return [UIFont applicationFontOfSize:12.0f];
}

+ (UIFont*)navigationTopicFont {
    return [UIFont applicationFontOfSize:12.0f];
}

+ (UIFont*)applicationStateTextLabelFont {
    return [UIFont boldApplicationFontOfSize:12.0f];
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
    return [UIFont applicationStateTextLabelFont];
}

+ (UIFont*)errorViewLabelFont {
    return [UIFont applicationStateTextLabelFont];
}

#pragma mark - detail view controller
+ (UIFont*)detailHeadlineLabelFont {
	return [UIFont headline1Font];
}
+ (UIFont*)detailGuestsLabelFont {
	return [UIFont paragraphFont];
}
+ (UIFont*)detailTopicsLabelFont {
	return [UIFont paragraphFont];
}
+ (UIFont*)detailPublishingDataLabelFont {
	return [UIFont paragraphFont];
}
+ (UIFont*)detailDescriptionTextViewFont {
	return [UIFont paragraphFont];
}

#pragma mark - settings view controller
+ (UIFont*)explanatoryTextViewFont {
	return [UIFont paragraphFont];
}

+ (UIFont*)toggleTrackingTitleLabelFont {
	return [UIFont headline3Font];
}

#pragma mark - contact view controller
+ (UIFont*)contactCharlieRoseIncTitleFont {
	return [UIFont headline3Font];
}

+ (UIFont*)contactCharlieRoseIncDetailFont {
	return [UIFont paragraphFont];
}

+ (UIFont*)contactDeveloperTitleFont {
	return [UIFont headline3Font];
}

+ (UIFont*)contactDeveloperDetailFont {
	return [UIFont paragraphFont];
}

#pragma mark - about view controller
+ (UIFont*)aboutTheProgramTitleLabelFont {
	return [self headline3Font];
}
+ (UIFont*)aboutTheProgramDescriptionTextViewFont {
	return [self paragraphFont];
}
+ (UIFont*)aboutTheAppLabelFont {
	return [self headline3Font];
}
+ (UIFont*)aboutTheAppDescriptionTextViewFont {
	return [self paragraphFont];
}

#pragma mark - privacy policy view controller
+ (UIFont*)privacyPolicyTextViewFont {
    return [self paragraphFont];
}


@end
