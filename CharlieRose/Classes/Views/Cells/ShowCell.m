//
//  ShowCell.m
//  CharlieRose
//
//  Created by Claudiu-Vlad Ursache on 25.11.12.
//  Copyright (c) 2012 Claudiu-Vlad Ursache. All rights reserved.
//

#import "ShowCell.h"
#import "Show.h"
#import "UIColor+CRAdditions.h"
#import "UIFont+CRAdditions.h"

@interface ShowCellContentView : UIView
@property(nonatomic, weak) ShowCell *cell;
@property(nonatomic, assign) BOOL highlighted;
@property(nonatomic, assign) BOOL selected;
@end

@implementation ShowCellContentView

- (id)initWithFrame:(CGRect)frame cell:(ShowCell *)cell {
	self = [super initWithFrame:frame];
    if (self) {
		_cell = cell;
        
        self.opaque = YES;
        self.backgroundColor = _cell.backgroundColor;
    
    }
    
    return self;
}

- (void)setHighlighted:(BOOL)highlighted {
    [_cell setHighlighted:highlighted];
    _highlighted = highlighted;
    [self setNeedsDisplay];
}

- (BOOL)isHighlighted {
    return _highlighted;
}

- (void)drawRect:(CGRect)rect
{
    
#define CELL_PADDING_TOP 5.0f
    
#define PADDING_RIGHT 2.0f
#define PADDING_LEFT 85.0f
#define PADDING_TOP 10.0f
#define PADDING_BOTTOM 5.0f
	
#define TITLE_WIDTH 160.0f
#define MAX_TITLE_HEIGHT 60.0f
#define TITLE_FONT_SIZE 12.0f
    
#define DESCRIPTION_WIDTH 190.0f
#define DESCRIPTION_FONT_SIZE 13.0f
    
#define DATE_WIDTH 100.0f
#define DATE_FONT_SIZE 10.0f
    
#define PADDING_FOR_TEXTS 155.0f
#define PADDING_FOR_DATE_AND_CATEGORY_LABELS 3.0f
    
    //image size: 148 * 96
    CGRect contentRect = self.bounds;
	
    UIFont *titleFont = [UIFont showCellTitleFont];
    UIFont *dateFont = [UIFont showCellDateFont];
    
    CGPoint pointToDraw = CGPointMake(0, 0);
    CGFloat actualFontSize = 0.0f;
    CGSize size = CGSizeMake(0, 0);
    CGSize titleSize = CGSizeMake(0, 0);
	
    //draw the arrow
    [[UIColor grayColor] set];
    CGFloat paddingRight = 10.0f;
    CGFloat ratio = 0.5f;
    UIImage *arrowImage = [UIImage imageNamed:@"arrow_right.png"];
    CGSize arrowImageSize = CGSizeMake(17.0f*ratio, 26.0f*ratio);
    CGRect arrowImageRect = CGRectMake(contentRect.size.width-arrowImageSize.width-paddingRight, (contentRect.size.height-arrowImageSize.height-CELL_PADDING_TOP)/2, arrowImageSize.width, arrowImageSize.height);
    [arrowImage drawInRect:arrowImageRect];
    
    //draw article name
    [[UIColor redColor] set];
    NSString *title = _cell.headline;
    CGRect titleSize2Frame = CGRectMake(PADDING_FOR_TEXTS, (contentRect.size.height-titleSize.height-CELL_PADDING_TOP)/2 , TITLE_WIDTH, MAX_TITLE_HEIGHT);
    CGSize titleSize2 = [title sizeWithFont:titleFont constrainedToSize:CGSizeMake(titleSize2Frame.size.width, titleSize2Frame.size.height) lineBreakMode:NSLineBreakByTruncatingTail];
    CGRect newTitleSize2Frame = CGRectMake(titleSize2Frame.origin.x, (contentRect.size.height-titleSize2.height-CELL_PADDING_TOP)/2, titleSize2.width, titleSize2.height);
    titleSize2 = [title drawInRect:newTitleSize2Frame withFont:titleFont lineBreakMode:NSLineBreakByTruncatingTail];
    CGPoint pointToDrawArticleName  = CGPointMake(newTitleSize2Frame.origin.x, newTitleSize2Frame.origin.y);
    
    //draw category name
    [[UIColor whiteColor] set];
    CGSize categoryNameSize = CGSizeMake(0, 0);
    NSString *categoryName = _cell.topics; //stringByAppendingFormat:@" ∙ "]
    size = [categoryName sizeWithFont:dateFont minFontSize:DATE_FONT_SIZE actualFontSize:&actualFontSize forWidth:DATE_WIDTH lineBreakMode:NSLineBreakByTruncatingTail];
    pointToDraw = CGPointMake(PADDING_FOR_TEXTS, pointToDrawArticleName.y+titleSize2.height+2.0f);
    size = [categoryName drawAtPoint:pointToDraw forWidth:DATE_WIDTH withFont:dateFont minFontSize:actualFontSize actualFontSize:&actualFontSize lineBreakMode:NSLineBreakByTruncatingTail baselineAdjustment:UIBaselineAdjustmentAlignBaselines];
    categoryNameSize = size;
    
    //draw date
    [[UIColor redColor] set];
    NSString *date = _cell.publishingDate;
    size = [date sizeWithFont:dateFont minFontSize:DATE_FONT_SIZE actualFontSize:&actualFontSize forWidth:DATE_WIDTH lineBreakMode:NSLineBreakByTruncatingTail];
    pointToDraw = CGPointMake(PADDING_FOR_TEXTS, pointToDrawArticleName.y-size.height);
    size = [date drawAtPoint:pointToDraw forWidth:DATE_WIDTH withFont:dateFont minFontSize:actualFontSize actualFontSize:&actualFontSize lineBreakMode:NSLineBreakByTruncatingTail baselineAdjustment:UIBaselineAdjustmentAlignBaselines];
}

@end

const CGRect kShowCellImageViewFrame = {5.0f, 5.0f, 140.f, 105.0f};

@interface ShowCell()
@property(nonatomic,strong,readwrite) UIView *overlayView;
@property(nonatomic,strong,readwrite) UILabel *titleLabel;
@end

@implementation ShowCell

- (void)setShow:(Show *)show {
	_show = show;
	_headline = _show.headline;
	_topics = _show.topics;
    
    [self setNeedsLayout];
    [self setNeedsDisplay];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
		
		self.opaque = YES;
		
        self.cellContentView = [[ShowCellContentView alloc] initWithFrame:self.contentView.bounds cell:self];
        _cellContentView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _cellContentView.contentMode = UIViewContentModeLeft;
        [self.contentView addSubview:_cellContentView];
		
        self.showImageView = [[UIImageView alloc] initWithFrame:kShowCellImageViewFrame];
        [self.contentView addSubview:_showImageView];
        
		self.backgroundView =[[UIView alloc] initWithFrame:self.bounds];
        self.backgroundView.backgroundColor = [UIColor dimmedBlack];
		self.contentView.backgroundColor = [UIColor dimmedBlack];
        
        self.selectedBackgroundView =[[UIView alloc] initWithFrame:self.bounds];
        self.selectedBackgroundView.backgroundColor = [UIColor dimmedBlack];
    }
    return self;
}

- (void)setBackgroundColor:(UIColor *)backgroundColor {
    [super setBackgroundColor:backgroundColor];
    self.cellContentView.backgroundColor = backgroundColor;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.imageView.frame = kShowCellImageViewFrame;
}

- (void)setHighlighted:(BOOL)highlighted {
    [self setNeedsDisplay];
}

@end
