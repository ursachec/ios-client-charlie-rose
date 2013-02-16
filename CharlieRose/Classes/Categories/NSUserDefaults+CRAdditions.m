//
//  NSUserDefaults+CRAdditions.m
//  CharlieRose
//
//  Created by Claudiu-Vlad Ursache on 10.02.13.
//  Copyright (c) 2013 Claudiu-Vlad Ursache. All rights reserved.
//

#import "NSUserDefaults+CRAdditions.h"

static NSString* kUserSettingTrackingDenied = @"kUserSettingTrackingDenied";

@implementation NSUserDefaults (CRAdditions)

+(BOOL)hasSetTrackingDenied {
    return [[NSUserDefaults standardUserDefaults] boolForKey:kUserSettingTrackingDenied];
}

+(void)setTrackingDenied:(BOOL)allowed {
    [[NSUserDefaults standardUserDefaults] setBool:allowed forKey:kUserSettingTrackingDenied];
}

@end
