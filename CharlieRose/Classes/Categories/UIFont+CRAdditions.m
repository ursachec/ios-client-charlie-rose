//
//  UIFont+CRAdditions.m
//  CharlieRose
//
//  Created by Claudiu-Vlad Ursache on 27.11.12.
//  Copyright (c) 2012 Claudiu-Vlad Ursache. All rights reserved.
//

#import "UIFont+CRAdditions.h"

static NSString * kFontNameRegular = @"Vollkorn";
static NSString * kFontNameBold = @"Vollkorn-Bold";

@implementation UIFont (CRAdditions)

+ (UIFont*)menuCellLabelFont {
    return [UIFont fontWithName:kFontNameBold size:14.0f];
}

+ (UIFont*)showCellTitleFont {
    return [UIFont fontWithName:kFontNameRegular size:12.0f];
}

+ (UIFont*)showCellDateFont {
    return [UIFont fontWithName:kFontNameRegular size:10.0f];
}

+ (UIFont*)topicCellFont {
    return [UIFont fontWithName:kFontNameBold size:12.0f];
}

+ (UIFont*)loadingViewLabelFont {
    return [UIFont fontWithName:kFontNameBold size:12.0f];
}

+ (UIFont*)errorViewLabelFont {
    return [UIFont fontWithName:kFontNameBold size:12.0f];
}


@end
