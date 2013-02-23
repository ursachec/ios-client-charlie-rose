//
//  UINonSelectableTextView.m
//  CharlieRose
//
//  Created by Claudiu-Vlad Ursache on 23.02.13.
//  Copyright (c) 2013 Claudiu-Vlad Ursache. All rights reserved.
//

#import "UINonSelectableTextView.h"

@implementation UINonSelectableTextView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (BOOL)canBecomeFirstResponder {
    return NO;
}

@end
