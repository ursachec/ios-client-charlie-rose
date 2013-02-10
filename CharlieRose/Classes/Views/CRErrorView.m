//
//  CRErrorView.m
//  CharlieRose
//
//  Created by Claudiu-Vlad Ursache on 10.02.13.
//  Copyright (c) 2013 Claudiu-Vlad Ursache. All rights reserved.
//

#import "CRErrorView.h"

@implementation CRErrorView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        _errorTextLabel = [[UILabel alloc] init];
        [_errorTextLabel setFrame:CGRectMake(40, 40, 40, 40)];
        [_errorTextLabel setBackgroundColor:[UIColor cyanColor]];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self addSubview:_errorTextLabel];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
