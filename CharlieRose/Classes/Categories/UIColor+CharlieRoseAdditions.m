//
//  UIColor+CharlieRoseAdditions.m
//  CharlieRose
//
//  Created by Claudiu-Vlad Ursache on 27.12.12.
//  Copyright (c) 2012 Claudiu-Vlad Ursache. All rights reserved.
//

#import "UIColor+CharlieRoseAdditions.h"

@implementation UIColor (CharlieRoseAdditions)

+ (UIColor*)dimmedBlack {
    return [UIColor colorWithRed:13.0f/255.0f green:18.0f/255.0f blue:4.0f/255.0f alpha:1.0f];
}

+ (UIColor*)headlineLabelTextColor {
    return [UIColor colorForElementsOnDescriptionViewController];
}

+ (UIColor*)guestsLabelTextColor {
    return [UIColor colorForElementsOnDescriptionViewController];
}
+ (UIColor*)topicsLabelTextColor {
    return [UIColor colorForElementsOnDescriptionViewController];
}

+ (UIColor*)publishingDateTextColor {
    return [UIColor colorForElementsOnDescriptionViewController];
}

+ (UIColor*)descriptionTextViewTextColor {
    return [UIColor colorForElementsOnDescriptionViewController];
}

+ (UIColor*)colorForElementsOnDescriptionViewController  {
    return [UIColor whiteColor];
}

@end
