//
//  ShowDetailViewController.m
//  CharlieRose
//
//  Created by Claudiu-Vlad Ursache on 27.11.12.
//  Copyright (c) 2012 Claudiu-Vlad Ursache. All rights reserved.
//

#import <MediaPlayer/MediaPlayer.h>
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

@interface ShowDetailViewController ()
@property(nonatomic, readwrite, strong) Show* show;
@property(nonatomic, readwrite, strong) NSString* currentShowID;

@property(nonatomic, readwrite, strong) NSDateFormatter *dateFormatter;

@property(nonatomic, readwrite, strong) IBOutlet UIScrollView* contentScrollView;

@property(nonatomic, readwrite, strong) IBOutlet UILabel* headlineLabel;
@property(nonatomic, readwrite, strong) IBOutlet UILabel* guestsLabel;
@property(nonatomic, readwrite, strong) IBOutlet UILabel* topicsLabel;
@property(nonatomic, readwrite, strong) IBOutlet UILabel* publishingDateLabel;
@property(nonatomic, readwrite, strong) IBOutlet UIImageView* showImageView;
@property(nonatomic, readwrite, strong) IBOutlet UITextView* descriptionTextView;

@property(nonatomic, readwrite, strong) IBOutlet UIButton* playButton;

@property (strong, nonatomic) MPMoviePlayerController *moviePlayer;

- (IBAction)playVideo:(id)sender;
- (IBAction)didSwipeRight:(id)sender;

@end

@implementation ShowDetailViewController

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
    
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)playVideo:(id)sender {
    NSURL *url = [CharlieRoseAPIClient videoURLForShowId:self.show.showID];
    self.moviePlayer =  [[MPMoviePlayerController alloc] initWithContentURL:url];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(moviePlayBackDidFinish:)
                                                 name:MPMoviePlayerPlaybackDidFinishNotification
                                               object:self.moviePlayer];
    self.moviePlayer.controlStyle = MPMovieControlStyleFullscreen;
    self.moviePlayer.shouldAutoplay = YES;
    [self.view addSubview:self.moviePlayer.view];
    [self.moviePlayer setFullscreen:YES animated:NO];
}

- (void) moviePlayBackDidFinish:(NSNotification*)notification {
    MPMoviePlayerController *player = [notification object];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:MPMoviePlayerPlaybackDidFinishNotification object:player];
    if ([player respondsToSelector:@selector(setFullscreen:animated:)]) {
        [player.view removeFromSuperview];
    }
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
	self.topicsLabel.text = show.topics;
	self.topicsLabel.textColor = [UIColor topicsLabelTextColor];
}

- (void)setupPublishingDateLabelWithShow:(Show *)show {
    NSString *dateString = [self.dateFormatter stringFromDate:show.datePublished];
	self.publishingDateLabel.backgroundColor = [UIColor clearColor];
	self.publishingDateLabel.text = dateString;
	self.publishingDateLabel.textColor = [UIColor publishingDateTextColor];
}

- (void)setupDescriptionTextViewWithShow:(Show *)show {
	self.descriptionTextView.backgroundColor = [UIColor clearColor];
	self.descriptionTextView.text = show.clipDescription;
	self.descriptionTextView.textColor = [UIColor descriptionTextViewTextColor];
}

- (void)setupImageViewWithShow:(Show *)show {
    NSURL* thumbURL = [NSURL URLWithString:show.imageURL];
    __weak UIImageView* blockImageView = self.showImageView;
    [blockImageView setImageWithURL:thumbURL
                   placeholderImage:[UIImage imageNamed:@"placeholder.png"]
                          completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
                              blockImageView.alpha = .0f;
                              [UIView animateWithDuration:0.5f animations:^{
                                  blockImageView.alpha = 1.0f;
                              }];
                          }];

}

- (void)setShow:(Show *)show {
	_show = show;
	if (show) {
		[self setupHeadlineLabelWithShow:show];
		[self setupGuestsLabelWithShow:show];
		[self setupTopicsLabelWithShow:show];
		[self setupPublishingDateLabelWithShow:show];
		[self setupDescriptionTextViewWithShow:show];
        [self setupImageViewWithShow:show];
	}
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
    [[InteractionsController sharedInteractionsController].deckController showCenterView];
}
@end
