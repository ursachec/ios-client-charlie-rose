//
//  UIColor+CRAdditions.m
//  CharlieRose
//
//  Created by Claudiu-Vlad Ursache on 27.12.12.
//  Copyright (c) 2012 Claudiu-Vlad Ursache. All rights reserved.
//

#import "UIColor+CRAdditions.h"

@implementation UIColor (CRAdditions)

+ (UIColor*)dimmedBlack {
    return [UIColor colorWithRed:13.0f/255.0f green:18.0f/255.0f blue:4.0f/255.0f alpha:1.0f];
}

+ (UIColor*)dimmedWhite {
    return [UIColor colorWithRed:1 green:1 blue:1 alpha:0.75f];
}

+ (UIColor*)moviePlayerLoadingStateLabelBackgroundColor {
    return [UIColor dimmedBlack];
}

+ (UIColor*)moviePlayerLoadingStateLabelTextColor {
    return [UIColor redColor];
}

+ (UIColor*)headlineLabelTextColor {
    return [UIColor redColor];
}

+ (UIColor*)guestsLabelTextColor {
    return [UIColor colorForSubHeadlineOnDescriptionViewController];
}
+ (UIColor*)topicsLabelTextColor {
    return [UIColor colorForSubHeadlineOnDescriptionViewController];
}

+ (UIColor*)publishingDateTextColor {
    return [UIColor colorForSubHeadlineOnDescriptionViewController];
}

+ (UIColor*)descriptionTextViewTextColor {
    return [UIColor whiteColor];
}

+ (UIColor*)colorForSubHeadlineOnDescriptionViewController {
    return [UIColor whiteColor];
}

+ (UIColor*)colorForElementsOnDescriptionViewController  {
    return [UIColor whiteColor];
}

@end
