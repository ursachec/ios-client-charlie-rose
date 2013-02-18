//
//  MenuCell.m
//  CharlieRose
//
//  Created by Claudiu-Vlad Ursache on 25.11.12.
//  Copyright (c) 2012 Claudiu-Vlad Ursache. All rights reserved.
//

#import "MenuCell.h"
#import "UIColor+CRAdditions.h"
#import "UIFont+CRAdditions.h"

@interface MenuCell ()
@property(nonatomic, strong, readwrite) UIView* customContentView;
@property(nonatomic, strong, readwrite) UILabel* menuItemLabel;
@end

@implementation MenuCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
		
		self.opaque = YES;
		
        UIView* cellContentView = [[UIView alloc] initWithFrame:self.contentView.bounds];
        cellContentView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        cellContentView.contentMode = UIViewContentModeLeft;
		
		UILabel* menuItemLabel = [[UILabel alloc] initWithFrame:cellContentView.frame];
		menuItemLabel.textColor = [UIColor whiteColor];
		menuItemLabel.font = [UIFont menuCellLabelFont];
		menuItemLabel.backgroundColor = [UIColor dimmedBlack];
		
		_menuItemLabel = menuItemLabel;
		[cellContentView addSubview:_menuItemLabel];
		
		_customContentView = cellContentView;
        [self.contentView addSubview:cellContentView];
		
		self.backgroundView =[[UIView alloc] initWithFrame:self.bounds];
        self.backgroundView.backgroundColor = [UIColor dimmedBlack];
		self.contentView.backgroundColor = [UIColor dimmedBlack];
        
        self.selectedBackgroundView =[[UIView alloc] initWithFrame:self.bounds];
        self.selectedBackgroundView.backgroundColor = [UIColor dimmedBlack];
		
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setMenuItemTitle:(NSString *)menuItemTitle {
	_menuItemTitle = menuItemTitle;
	self.menuItemLabel.text = _menuItemTitle;
}

@end
