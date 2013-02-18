//
//  TopicCell.m
//  CharlieRose
//
//  Created by Claudiu-Vlad Ursache on 25.11.12.
//  Copyright (c) 2012 Claudiu-Vlad Ursache. All rights reserved.
//

#import "TopicCell.h"
#import "UIColor+CRAdditions.h"
#import "UIFont+CRAdditions.h"

@interface TopicCell ()
@property(nonatomic, strong, readwrite) UIView* customContentView;
@property(nonatomic, strong, readwrite) UILabel* topicLabel;
@end

@implementation TopicCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
		
		self.opaque = YES;
		
        UIView* cellContentView = [[UIView alloc] initWithFrame:self.contentView.bounds];
        cellContentView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        cellContentView.contentMode = UIViewContentModeLeft;
		
		CGRect topicLabelFrame = CGRectMake(30.0f, 0, CGRectGetWidth(cellContentView.frame), CGRectGetHeight(cellContentView.frame));
		UILabel* topicLabel = [[UILabel alloc] initWithFrame:topicLabelFrame];
		topicLabel.textColor = [UIColor whiteColor];
		topicLabel.font = [UIFont topicCellFont];
		topicLabel.backgroundColor = [UIColor dimmedBlack];
		
		_topicLabel = topicLabel;
		[cellContentView addSubview:_topicLabel];
		
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

-(void)setTopic:(NSString *)topic {
	_topic = topic;
	self.topicLabel.text = _topic;
}

@end
