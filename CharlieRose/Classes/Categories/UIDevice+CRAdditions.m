//
//  UIDevice+CRAdditions.m
//  CharlieRose
//
//  Created by Claudiu-Vlad Ursache on 21.02.13.
//  Copyright (c) 2013 Claudiu-Vlad Ursache. All rights reserved.
//

#import "UIDevice+CRAdditions.h"

@implementation UIDevice (CRAdditions)

+ (BOOL)isIphone5 {
    return (568 == UIScreen.mainScreen.bounds.size.height);
}


@end
