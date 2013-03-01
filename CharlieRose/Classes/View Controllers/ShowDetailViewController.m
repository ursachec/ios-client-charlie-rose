//
//  ShowDetailViewController.m
//  CharlieRose
//
//  Created by Claudiu-Vlad Ursache on 27.11.12.
//  Copyright (c) 2012 Claudiu-Vlad Ursache. All rights reserved.
//

#import <SDWebImage/UIImageView+WebCache.h>

#import "ShowDetailViewController.h"
#import "IIViewDeckController.h"
#import "UIView+CRAdditions.h"
#import "Show.h"
#import "InteractionsController.h"
#import "InteractionsController+Movement.h"
#import "CRErrorView.h"
#import "UIColor+CRAdditions.h"
#import "CharlieRoseAPIClient.h"
#import "UIFont+CRAdditions.h"
#import "UIApplication+CRAdditions.h"
#import "UIDevice+CRAdditions.h"
#import "CVUMoviePlayerView.h"
#import <MediaPlayer/MediaPlayer.h>

@interface ShowDetailViewController ()<InteractionsControllerFullViewTapDelegate>
@property(nonatomic, readwrite, strong) NSString* currentShowID;
@property(nonatomic, readwrite, strong) NSDateFormatter *dateFormatter;

@property(nonatomic, readwrite, strong) IBOutlet UIScrollView* contentScrollView;
@property(nonatomic, readwrite, strong) IBOutlet UILabel* headlineLabel;
@property(nonatomic, readwrite, strong) IBOutlet UILabel* guestsLabel;
@property(nonatomic, readwrite, strong) IBOutlet UILabel* topicsLabel;
@property(nonatomic, readwrite, strong) IBOutlet UILabel* publishingDateLabel;
@property(nonatomic, readwrite, strong) IBOutlet UIImageView* showImageView;
@property(nonatomic, readwrite, strong) IBOutlet UITextView* descriptionTextView;
@property(nonatomic, readwrite, strong) IBOutlet CVUMoviePlayerView* moviePlayerView;

- (IBAction)didSwipeRight:(id)sender;
@end

@implementation ShowDetailViewController


#pragma mark - lifecycle init
- (id)init {
    self = [self initWithShow:nil];
    return self;
}

- (id)initWithShow:(Show *)show {
    self = [super initWithNibName:nil bundle:nil];
    if (!self) {
        return nil;
    }
    _show = show;
    
    _dateFormatter = [[NSDateFormatter alloc] init];
    [_dateFormatter setTimeStyle:NSDateFormatterNoStyle];
    [_dateFormatter setDateStyle:NSDateFormatterFullStyle];
    [_dateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
	
    self.headlineLabel.font = [UIFont detailHeadlineLabelFont];
    self.guestsLabel.font = [UIFont detailGuestsLabelFont];
    self.topicsLabel.font = [UIFont detailTopicsLabelFont];
    self.publishingDateLabel.font = [UIFont detailPublishingDataLabelFont];
    self.descriptionTextView.font = [UIFont detailDescriptionTextViewFont];
    
    // hide the decription text view if older than iPhone5
    if (NO == UIDevice.isIphone5) {
        [self.descriptionTextView removeFromSuperview];
        self.descriptionTextView = nil;
    }
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - setters

- (void)setupHeadlineLabelWithShow:(Show *)show {
	self.headlineLabel.backgroundColor = [UIColor clearColor];
	self.headlineLabel.text = show.headline;
	self.headlineLabel.textColor = [UIColor headlineLabelTextColor];
}

- (void)setupGuestsLabelWithShow:(Show *)show {
	self.guestsLabel.backgroundColor = [UIColor clearColor];
	self.guestsLabel.text = show.guests;
	self.guestsLabel.textColor = [UIColor guestsLabelTextColor];
}

- (void)setupTopicsLabelWithShow:(Show *)show {
	self.topicsLabel.backgroundColor = [UIColor clearColor];
	self.topicsLabel.text = [NSString stringWithFormat:@"in %@", show.topics];
	self.topicsLabel.textColor = [UIColor topicsLabelTextColor];
}

- (void)setupPublishingDateLabelWithShow:(Show *)show {
    NSString *dateString = [self.dateFormatter stringFromDate:show.datePublished];
	self.publishingDateLabel.backgroundColor = [UIColor clearColor];
	self.publishingDateLabel.text = [NSString stringWithFormat:@"on %@",dateString];
	self.publishingDateLabel.textColor = [UIColor publishingDateTextColor];
}

- (void)setupDescriptionTextViewWithShow:(Show *)show {
	self.descriptionTextView.backgroundColor = [UIColor clearColor];
	self.descriptionTextView.text = show.clipDescription;
	self.descriptionTextView.textColor = [UIColor descriptionTextViewTextColor];
}

- (void)setShow:(Show *)show {
	_show = show;
	if (show) {
		[self setupHeadlineLabelWithShow:show];
		[self setupGuestsLabelWithShow:show];
		[self setupTopicsLabelWithShow:show];
		[self setupPublishingDateLabelWithShow:show];
		[self setupDescriptionTextViewWithShow:show];
        [self showVideoPlayerWithShow:show];
	}
}

#pragma mark - video player

- (void)removeCurrentMoviePlayerView {
    [self.moviePlayerView pauseVideo];
    [self.moviePlayerView removeFromSuperview];
    self.moviePlayerView = nil;
}

- (void)loadMoviePlayerPlaceholderImageAtURL:(NSURL*)imageURL
                            placeholderImage:(UIImage*)placeholderImage {
    __weak UIImageView* blockImageView = self.moviePlayerView.placeholderImageView;
    [blockImageView setImageWithURL:imageURL
                   placeholderImage:placeholderImage
                          completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
                          }];
}

- (void)showMoviePlayerViewInFrame:(CGRect)frame
                          videoURL:(NSURL*)videoURL {
    UIImage* playButtonImage = [UIImage imageNamed:@"play_button.png"];
    self.moviePlayerView = [[CVUMoviePlayerView alloc] initWithFrame:frame
                                                    placeholderImage:nil
                                                            videoURL:videoURL
                                                     playButtonImage:playButtonImage];
    [self.view addSubview:self.moviePlayerView];
}

- (void)showVideoPlayerWithShow:(Show*)show {
    
    [self removeCurrentMoviePlayerView];
    
    CGRect frame = self.showImageView.frame;
    
    NSURL* videoURL = [CharlieRoseAPIClient videoURLForShowVidlyURL:show.vidlyURL];
    [self showMoviePlayerViewInFrame:frame
                            videoURL:videoURL];
    
    NSURL* imageURL = [CharlieRoseAPIClient imageURLForShowId:show.showID];
    [self loadMoviePlayerPlaceHolderImageAtURL:imageURL];
    
    
    [[InteractionsController sharedInteractionsController] registerForNotificationsFromMoviePlayer:self.moviePlayerView.moviePlayerController];
}

- (void)loadMoviePlayerPlaceHolderImageAtURL:(NSURL*)imageURL {
    UIImage* placeholderImage = [UIImage imageNamed:@"placeholder.png"];
    [self loadMoviePlayerPlaceholderImageAtURL:imageURL
                              placeholderImage:placeholderImage];
}

#pragma mark - high level show

- (void)presentWithShow:(Show*)show {
	BOOL showIdTheSameAsCurrent = ([self.show.showID compare:show.showID]==NSOrderedSame);
	if (self.show.showID!=nil && showIdTheSameAsCurrent) {
		return;
	}
    
    self.show = show;
}

- (UIView*)superViewForLoadingView {
	return self.contentScrollView;
}

#pragma mark - UIGestureRecognizer delegate methods

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer
       shouldReceiveTouch:(UITouch *)touch {
    if ([touch.view isKindOfClass:[UIButton class]]) {
        return NO;
    }
    return YES;
}

- (IBAction)didSwipeRight:(id)sender {
    [[UIApplication sharedInteractionsController] reactToSwipeOnShowDetailViewController];
}

- (IBAction)didTapOnView:(id)sender {
    [[UIApplication sharedInteractionsController] reactToTapOnShowDetailViewController];
}

@end
